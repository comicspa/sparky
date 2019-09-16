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



  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');


    ModelUserInfo modelUserInfo = new ModelUserInfo();


    modelUserInfo.id = readStringToByteBuffer();
    modelUserInfo.creatorId = readStringToByteBuffer();
    modelUserInfo.bio = readStringToByteBuffer();
    modelUserInfo.comi = getUint32();
    modelUserInfo.followers = getUint32();
    modelUserInfo.following = getUint32();
    modelUserInfo.likes = getUint32();

    int testMode = getUint32();
    if(1 == testMode)
    {
      int testSocial = 1;
      switch(testSocial)
      {
        case 1:
          {
            modelUserInfo.socialProviderType = e_social_provider_type.google;
          }
          break;

        case 2:
          {
            modelUserInfo.socialProviderType = e_social_provider_type.facebook;
          }
          break;

        case 3:
          {
            modelUserInfo.socialProviderType = e_social_provider_type.twitter;
          }
          break;
      }

      modelUserInfo.email = 'testUser@test.com';
      modelUserInfo.userName = 'testUserName';
      modelUserInfo.displayName = 'testDisplayName';
      modelUserInfo.photoUrl   = await ManageFirebaseStorage.getDownloadUrl('presets/test_profile.png');

      while(null == modelUserInfo.photoUrl )
      {
      }

      ModelUserInfo.instance = modelUserInfo;
      print('1 : ${ModelUserInfo.getInstance().photoUrl}');

    }

  }



}
