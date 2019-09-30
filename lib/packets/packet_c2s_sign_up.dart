import 'dart:io';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_sign_up.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SSignUp extends PacketC2SCommon
{
  String _uId;
  e_social_provider_type _socialProviderType;

  PacketC2SSignUp()
  {
    type = e_packet_type.c2s_sign_up;
  }

  void generate(String uId,e_social_provider_type socialProviderType)
  {
    _uId = uId;
    _socialProviderType = socialProviderType;
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
      'social_provider_type': _socialProviderType.index,
      'creator_id':'',
      'bio':'자기 소개입니다.',
      'comi':0,
      'followers':0,
      'following':0,
      'likes':0,
      'sign_in':0
    }).then((_) {

      PacketS2CSignUp packet = new PacketS2CSignUp();
      packet.parseFireBaseDBJson(onFetchDone);

    });

  }


  Future<void> _fetchBytes(onFetchDone) async
  {
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CSignUp packet = new PacketS2CSignUp();
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

  }

}