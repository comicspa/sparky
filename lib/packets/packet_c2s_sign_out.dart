import 'dart:io';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_sign_out.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';


class PacketC2SSignOut extends PacketC2SCommon
{
  String _uId;
  int _databaseType = 1;

  PacketC2SSignOut()
  {
    type = e_packet_type.c2s_sign_out;
  }

  void generate(String uId)
  {
    _uId = uId;
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
    print('PacketC2SSignOut : _fetchFirestoreDB started');

    await ManageFireBaseCloudFireStore.reference.collection(ModelUserInfo.ModelName)
        .document(_uId)
        .updateData({
      'sign_in':0,
    }).then((_) {

      PacketS2CSignOut packet = new PacketS2CSignOut();
      packet.parseFireBaseDBJson(onFetchDone);

      //});
    });
  }


  Future<void> _fetchRealtimeDB(onFetchDone) async
  {
    print('PacketC2SSignOut : _fetchRealtimeDB started');

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child(ModelUserInfo.ModelName);
    modelUserInfoReference.child(_uId).update({
      'sign_in':0
    }).then((_) {

      PacketS2CSignOut packet = new PacketS2CSignOut();
      packet.parseFireBaseDBJson(onFetchDone);

    });

  }

}