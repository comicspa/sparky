import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/manage/manage_firebase_storage.dart';


class PacketS2CUserInfo extends PacketS2CCommon
{
  PacketS2CUserInfo()
  {
    type = e_packet_type.s2c_user_info;
  }



  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    ModelUserInfo.getInstance().id = readStringToByteBuffer();
    ModelUserInfo.getInstance().creatorId = readStringToByteBuffer();
    ModelUserInfo.getInstance().bio = readStringToByteBuffer();
    ModelUserInfo.getInstance().comi = getUint32();
    ModelUserInfo.getInstance().followers = getUint32();
    ModelUserInfo.getInstance().following = getUint32();
    ModelUserInfo.getInstance().likes = getUint32();

    int testMode = getUint32();
    if(1 == testMode)
    {
      int testSocial = 1;
      switch(testSocial)
      {
        case 1:
          {
            ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.google;
          }
          break;

        case 2:
          {
            ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.facebook;
          }
          break;

        case 3:
          {
            ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.twitter;
          }
          break;
      }

      ModelUserInfo.getInstance().email = 'testUser@test.com';
      ModelUserInfo.getInstance().userName = 'testUserName';
      ModelUserInfo.getInstance().displayName = 'testDisplayName';
      ModelUserInfo.getInstance().photoUrl   = await ManageFirebaseStorage.getDownloadUrl('presets/test_profile.png');

      print('1 : ${ModelUserInfo.getInstance().photoUrl}');
    }


    if(null != onFetchDone)
      onFetchDone(this);

  }



}
