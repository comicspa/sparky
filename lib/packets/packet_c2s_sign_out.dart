import 'dart:io';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_sign_out.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SSignOut extends PacketC2SCommon
{
  String _uId;

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
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<void> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SSignOut : fetchFireBaseDB started');

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_user_info');
    modelUserInfoReference.child(_uId).update({
      'sign_in':0
    }).then((_) {

      PacketS2CSignOut packet = new PacketS2CSignOut();
      packet.parseFireBaseDBJson(onFetchDone);

    });

  }

}