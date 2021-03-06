import 'dart:convert';
import 'dart:io';

import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_sign_up.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';


class PacketC2SSignUp extends PacketC2SCommon
{
  String _uId;
  e_social_provider_type _socialProviderType;
  String _emailAddress;
  int _databaseType = 1;

  PacketC2SSignUp()
  {
    type = e_packet_type.c2s_sign_up;
  }

  void generate(String uId,e_social_provider_type socialProviderType,String emailAddress)
  {
    _uId = uId;
    _socialProviderType = socialProviderType;
    _emailAddress = emailAddress;
  }

  Future<void> fetch(onFetchDone) async
  {
    switch(_databaseType)
    {
      case 0:
        {
          _fetchRealtimeDB(onFetchDone);
        }
        break;

      case 1:
        {
          _fetchFirestoreDB(onFetchDone);
        }
        break;

      default:
        break;
    }
  }


  Future<void> _fetchFirestoreDB(onFetchDone) async
  {
    print('PacketC2SSignUp : _fetchFirestoreDB started');

    await ManageFireBaseCloudFireStore.reference.collection(ModelUserInfo.ModelName)
        .document(_uId)
        .setData({
      'social_provider_type': _socialProviderType.index,
      'bio':'',
      'comi':0,
      'followers':0,
      'following':0,
      'likes':0,
      'sign_in':1,
      'create_time':DateTime.now().millisecondsSinceEpoch.toString(),
      'update_time':DateTime.now().millisecondsSinceEpoch.toString(),
      'display_name':ModelUserInfo.getInstance().displayName,
      'photo_url':ModelUserInfo.getInstance().photoUrl,
      'cloud_messaging_token':ModelUserInfo.getInstance().cloudMessagingToken,
    }).then((_) {

      PacketS2CSignUp packet = new PacketS2CSignUp();
      packet.parseFireBaseDBJson(onFetchDone);

      //});
    });
  }


  Future<void> _fetchRealtimeDB(onFetchDone) async
  {
    print('PacketC2SSignUp : _fetchRealtimeDB started');

    //List<int> emailAddressBytes = utf8.encode(_emailAddress);
    //Base64Codec base64Codec = new Base64Codec();
    //String emailAddressBase64 = base64Codec.encode(emailAddressBytes);

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_user_info');
    modelUserInfoReference.child(_uId).update({
      'social_provider_type': _socialProviderType.index,
      'bio':'',
      'comi':0,
      'followers':0,
      'following':0,
      'likes':0,
      'sign_in':1,
      'create_time':DateTime.now().millisecondsSinceEpoch.toString(),
      'update_time':DateTime.now().millisecondsSinceEpoch.toString(),
      'display_name':ModelUserInfo.getInstance().displayName,
      'photo_url':ModelUserInfo.getInstance().photoUrl,
      'cloud_messaging_token':ModelUserInfo.getInstance().cloudMessagingToken,
    }).then((_) {

      //DatabaseReference modelUserInfoDeviceIdReference = modelUserInfoReference.child('device_id');
      //modelUserInfoDeviceIdReference.set({
      //  '0': ManageDeviceInfo.deviceId,
      //}).then((_) {

        PacketS2CSignUp packet = new PacketS2CSignUp();
        packet.parseFireBaseDBJson(onFetchDone);

      //});
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