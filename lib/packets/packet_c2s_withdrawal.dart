import 'dart:io';
import 'dart:typed_data';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_withdrawal.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';



class PacketC2SWithdrawal extends PacketC2SCommon
{
  String _uId;

  PacketC2SWithdrawal()
  {
    type = e_packet_type.c2s_withdrawal;
  }

  void generate(String uId)
  {
    _uId = uId;
  }


  Future<void> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<void> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SWithdrawal : fetchFireBaseDB started');
    print('uId : ${_uId}');

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_user_info').child(_uId);
    modelUserInfoReference.remove().then((_) {

      PacketS2CWithdrawal packet = new PacketS2CWithdrawal();
      packet.parseFireBaseDBJson(onFetchDone);

    });

    return null;
  }



  void _fetchBytes(onFetchDone) async
  {
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CWithdrawal packet = new PacketS2CWithdrawal();
      packet.parseBytes(event);
    });

    List<int> userIdList = PacketUtility.readyWriteStringToByteBuffer(_uId);

    int packetBodySize  = PacketUtility.getStringTotalLength(userIdList);
    generateHeader(packetBodySize);

    writeStringToByteBuffer(userIdList);

    socket.add(packet);

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

  }

}