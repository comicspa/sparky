import 'dart:typed_data';
import 'dart:convert';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_preset.dart';


class PacketS2CPreset extends PacketS2CCommon
{
  PacketS2CPreset()
  {
    type = e_packet_type.s2c_preset;
  }




  Future<void> parseJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    String version = jsonMap['version'];
    print('parseJson - current version : $version , app version : ${ModelPreset.version}');

    var linkJson = jsonMap['link'];
    ModelPreset.faqUrl = linkJson['faq'];
    print('parseJson - faq : ${ModelPreset.faqUrl}');

    ModelPreset.privacyPolicyUrl = linkJson['privacy_policy'];
    print('parseJson - privacy_policy : ${ModelPreset.privacyPolicyUrl}');

    ModelPreset.termsOfUseUrl = linkJson['terms_of_use'];
    print('parsejson - terms_of_use : ${ModelPreset.termsOfUseUrl}');

    ModelPreset.homepageUrl = linkJson['home_page'];
    print('parseJson - homepageUrl : ${ModelPreset.homepageUrl}');

    if(null != onFetchDone)
      onFetchDone(this);
  }



}