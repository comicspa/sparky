
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_comic_info.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SComicInfo extends PacketC2SCommon
{
  String _userId;
  String _comicId;
  int _fetchStatus = 0;
  PacketS2CComicInfo _packetS2CComicInfo;

  PacketC2SComicInfo()
  {
    type = e_packet_type.c2s_comic_info;
  }

  void generate(String userId,String comicId)
  {
    _fetchStatus = 0;
    _userId = userId;
    _comicId = comicId;

    if(null != _packetS2CComicInfo)
      _packetS2CComicInfo.clear();
    else
      _packetS2CComicInfo = new PacketS2CComicInfo();

  }

  Future<ModelComicInfo> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<ModelComicInfo> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SComicDetailInfo : fetchFireBaseDB started');

    /*
    if(3 == _fetchStatus)
      return ModelComicInfo.getInstance();
    else if(0 == _fetchStatus)
    {
      _fetchStatus = 1;

      String id = '${_userId}_${_comicId}';
      print('id : $id');
      DatabaseReference modelComicDetailInfoReference = ManageFirebaseDatabase
          .reference.child('model_comic_detail_info').child(id);
      modelComicDetailInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SComicDetailInfo : fetchFireBaseDB ] - ${snapshot
            .value}');

        _fetchStatus = 2;

        if(null != _packetS2CComicInfo)
          _packetS2CComicInfo.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;

        return ModelComicInfo.getInstance();
      });
    }

     */

    return null;
  }

}