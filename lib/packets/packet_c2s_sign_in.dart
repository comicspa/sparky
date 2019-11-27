import 'dart:io';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_s2c_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';


class PacketC2SSignIn extends PacketC2SCommon
{
  String _uId;
  OnFetchDone _onFetchDone;
  int _databaseType = 1;

  PacketC2SSignIn()
  {
    type = e_packet_type.c2s_sign_in;
  }

  void generate(String uId,OnFetchDone onFetchDone)
  {
    _uId = uId;
    _onFetchDone = onFetchDone;
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
        .updateData({
      'sign_in':1,
      'update_time':DateTime.now().millisecondsSinceEpoch.toString(),
    }).then((_) {

      PacketS2CSignIn packet = new PacketS2CSignIn();
      packet.parseFireBaseDBJson(_onFetchDone);

      //});
    });
  }



  Future<void> _fetchRealtimeDB(onFetchDone) async
  {
    print('PacketC2SSignIn : _fetchRealtimeDB started');

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child(ModelUserInfo.ModelName);
    modelUserInfoReference.child(_uId).update({
      'sign_in':1,
      'update_time':DateTime.now().millisecondsSinceEpoch.toString(),
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