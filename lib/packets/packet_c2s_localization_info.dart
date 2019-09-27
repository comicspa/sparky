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
  String _localeCode = 'ko';
  String _languageCode = 'kr';


  PacketC2SLocalizationInfo()
  {
    type = e_packet_type.c2s_localization_info;
  }

  void generate(String localeCode,String languageCode)
  {
    localeCode =  localeCode.toLowerCase();
    switch(localeCode)
    {
      case  'ko':
        _localeCode = 'ko';
        break;

      case 'us':
        _localeCode = 'us';
        break;

      default:
        _localeCode = 'ko';
        break;
    }

    languageCode = languageCode.toLowerCase();
    switch(languageCode)
    {
      case 'kr':
        _languageCode = 'kr';
        break;

      case 'en':
        _languageCode = 'en';
        break;

      default:
        _languageCode = 'kr';
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
    print('PacketC2SLocalizationInfo : fetchFireBaseDB started');

    if(null != ModelLocalizationInfo.languagePack)
      return ModelLocalizationInfo.languagePack;

    String id = '${_localeCode}_${_languageCode}';
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