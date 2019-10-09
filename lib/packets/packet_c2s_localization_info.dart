import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_s2c_localization_info.dart';
import 'package:sparky/models/model_localization_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_message.dart';


class PacketC2SLocalizationInfo extends PacketC2SCommon
{
  String _languageCode = 'ko';
  String _localeCode = 'kr';

  PacketC2SLocalizationInfo()
  {
    type = e_packet_type.c2s_localization_info;
  }

  void generate(String languageCode,String localeCode)
  {

    languageCode = languageCode.toLowerCase();
    switch(languageCode)
    {
      case 'en':
        _languageCode = 'en';
        break;

      case  'ko':
      default:
        _languageCode = 'ko';
        break;
    }

    localeCode =  localeCode.toLowerCase();
    switch(localeCode)
    {

      case 'us':
        _localeCode = 'us';
        break;

      case 'kr':
      default:
        _localeCode = 'kr';
        break;
    }




  }


  void _onFetchDone(PacketS2CCommon s2cPacket)
  {
    print('[PacketC2SLocalizationInfo] : onFetchDone');
    ManageMessage.streamController.add(e_packet_type.s2c_localization_info);
  }

  Future<Map<dynamic,dynamic>> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<Map<dynamic,dynamic>> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SLocalizationInfo : fetchFireBaseDB started - languageCode : ${_languageCode} , localeCode : ${_localeCode}');

    if(null != ModelLocalizationInfo.languagePack)
      return ModelLocalizationInfo.languagePack;

    String id = '${_languageCode}_${_localeCode}';
    print('id : $id');

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_localization_info').child(id);
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('[PacketC2SLocalizationInfo:fetchFireBaseDB ] - ${snapshot.value}');

      PacketS2CLocalizationInfo packet = new PacketS2CLocalizationInfo();
      packet.parseFireBaseDBJson(snapshot.value , _onFetchDone);

      return ModelLocalizationInfo.languagePack;

    });

    return null;
  }


}