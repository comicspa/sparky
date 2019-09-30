import 'dart:io';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SSignIn extends PacketC2SCommon
{
  String _uId;

  PacketC2SSignIn()
  {
    type = e_packet_type.c2s_sign_in;
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

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_user_info');
    modelUserInfoReference.child(_uId).set({
      'sign_in':1
    }).then((_) {

      PacketS2CSignIn packet = new PacketS2CSignIn();
      packet.parseFireBaseDBJson(onFetchDone);

    });

  }


  Future<void> _fetchBytes(onFetchDone) async
  {
    /*
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CSignup packet = new PacketS2CSignup();
      packet.parseBytes(event);
      onFetchDone(packet);
    });


    List<int> socialIdList = PacketUtility.readyWriteStringToByteBuffer(_uId);
    int socialProviderTypeIndex = _socialProviderType.index;

    int packetBodySize  = PacketUtility.getStringTotalLength(socialIdList) + 4;
    generateHeader(packetBodySize);

    writeStringToByteBuffer(socialIdList);
    setUint32(socialProviderTypeIndex);

    socket.add(packet);

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

     */

  }

}