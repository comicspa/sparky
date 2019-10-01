import 'dart:io';
import 'dart:typed_data';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_register_creator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SRegisterCreator extends PacketC2SCommon
{
  String _uId;

  PacketC2SRegisterCreator()
  {
    type = e_packet_type.c2s_register_creator;
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
    print('PacketC2SSignUp : fetchFireBaseDB started');

    String creatorId = DateTime.now().millisecondsSinceEpoch.toString();
    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_user_info');
    modelUserInfoReference.child(_uId).update({
      'creator_id':creatorId
    }).then((_) {

      PacketS2CRegisterCreator packet = new PacketS2CRegisterCreator();
      packet.parseFireBaseDBJson(onFetchDone);

    });

  }

  void fetchBytes(onPacketRegisterCreatorFetchDone) async
  {
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CRegisterCreator packet = new PacketS2CRegisterCreator();
      packet.parseBytes(event);
      onPacketRegisterCreatorFetchDone(packet);
    });


    List<int> socialIdList = PacketUtility.readyWriteStringToByteBuffer(_uId);

    int packetBodySize  = PacketUtility.getStringTotalLength(socialIdList);
    generateHeader(packetBodySize);

    writeStringToByteBuffer(socialIdList);

    socket.add(packet);

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

  }

}