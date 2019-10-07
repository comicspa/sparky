import 'dart:io';
import 'dart:typed_data';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_register_comic.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SRegisterComic extends PacketC2SCommon
{
  String _uId;

  PacketC2SRegisterComic()
  {
    type = e_packet_type.c2s_register_comic;
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
    print('PacketC2SRegisterComic : fetchFireBaseDB started');

    //List<int> uIdBytes = utf8.encode(_uId);
    //Base64Codec base64Codec = new Base64Codec();
    //String uIdBase64 = base64Codec.encode(uIdBytes);

    String creatorId = DateTime.now().millisecondsSinceEpoch.toString();
    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_comic_info');
    modelUserInfoReference.child(_uId).update({
      'creator_id':creatorId
    }).then((_) {

      PacketS2CRegisterComic packet = new PacketS2CRegisterComic();
      packet.parseFireBaseDBJson(onFetchDone);

    });

  }



}