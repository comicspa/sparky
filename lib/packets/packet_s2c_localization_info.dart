import 'dart:typed_data';

import 'package:sparky/models/model_preset.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_localization_info.dart';



class PacketS2CLocalizationInfo extends PacketS2CCommon
{
  PacketS2CLocalizationInfo()
  {
    type = e_packet_type.s2c_localization_info;
  }

  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    print('[PacketS2CLocalizationInfo::parseFireBaseDBJson ]');

    status = e_packet_status.start_dispatch_respond;
    ModelLocalizationInfo.languagePack = jsonMap;

    //String name = ModelLocalizationInfo.getText('test','name');
    //print('name : $name');

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }



}