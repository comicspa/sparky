import 'dart:typed_data';

import 'package:sparky/models/model_user_info.dart' as prefix0;
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/manage/manage_firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PacketS2CUserInfo extends PacketS2CCommon
{

  PacketS2CUserInfo()
  {
    type = e_packet_type.s2c_user_info;
  }

  Future<void> parseCloudFirestoreJson(Map<String,dynamic> jsonMap , onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;

    ModelUserInfo.getInstance().bio = jsonMap['bio'];
    ModelUserInfo.getInstance().cloudMessagingToken = jsonMap['cloud_messaging_token'];
    ModelUserInfo.getInstance().comi = jsonMap['comi'];
    ModelUserInfo.getInstance().displayName = jsonMap['display_name'];
    ModelUserInfo.getInstance().followers = jsonMap['followers'];
    ModelUserInfo.getInstance().following = jsonMap['following'];
    ModelUserInfo.getInstance().likes = jsonMap['likes'];
    ModelUserInfo.getInstance().photoUrl = jsonMap['photo_url'];
    ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.values[jsonMap['social_provider_type']];
    if(1 == jsonMap['sign_in'])
      ModelUserInfo.getInstance().signedIn = true;
    else
      ModelUserInfo.getInstance().signedIn = false;

    print(ModelUserInfo.getInstance().toString());

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
    else
      print('null == onFetchDone');
  }



  Future<void> parseRealtimeDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;

    ModelUserInfo.getInstance().bio = jsonMap['bio'];
    ModelUserInfo.getInstance().comi = jsonMap['comi'];
    ModelUserInfo.getInstance().followers = jsonMap['followers'];
    ModelUserInfo.getInstance().following = jsonMap['following'];
    ModelUserInfo.getInstance().likes = jsonMap['likes'];
    ModelUserInfo.getInstance().displayName = jsonMap['display_name'];
    //ModelUserInfo.getInstance().userName = jsonMap['user_name'];
    //ModelUserInfo.getInstance().email = jsonMap['email_address'];
    ModelUserInfo.getInstance().photoUrl   = jsonMap['photo_url'];

    if(jsonMap.containsKey('creators'))
    {
      for (var creator in jsonMap['creators'].entries)
      {
        if(null == ModelUserInfo.getInstance().creatorIdList)
          ModelUserInfo.getInstance().creatorIdList = new List<String>();
        else
          ModelUserInfo.getInstance().creatorIdList.clear();

        ModelUserInfo.getInstance().creatorIdList.add(creator.value);
      }
    }

    if(jsonMap.containsKey('translators'))
    {
      for (var translator in jsonMap['translators'].entries)
      {
        if(null == ModelUserInfo.getInstance().translatorIdList)
          ModelUserInfo.getInstance().translatorIdList = new List<String>();
        else
          ModelUserInfo.getInstance().translatorIdList.clear();

        ModelUserInfo.getInstance().translatorIdList.add(translator.value);
      }
    }

    //ModelUserInfo.getInstance().creatorId = creatorsMap[0];
    //print('creatorId : ${ModelUserInfo.getInstance().creatorId}');

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
    else
      print('null == onFetchDone');
  }


  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    ModelUserInfo.getInstance().uId = readStringToByteBuffer();
    //ModelUserInfo.getInstance().creatorId = readStringToByteBuffer();
    ModelUserInfo.getInstance().bio = readStringToByteBuffer();
    ModelUserInfo.getInstance().comi = getUint32();
    ModelUserInfo.getInstance().followers = getUint32();
    ModelUserInfo.getInstance().following = getUint32();
    ModelUserInfo.getInstance().likes = getUint32();

    int testMode = getUint32();
    if(1 == testMode)
    {
      int testSocial = 1;
      ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.values[testSocial];
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
