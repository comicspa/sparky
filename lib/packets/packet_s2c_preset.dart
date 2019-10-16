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




  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;

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

    ModelPreset.termsOfUseRegisterComicUrl = linkJson['terms_of_use_register_comic'];
    print('parseJson - terms_of_use_register_comic : ${ModelPreset.termsOfUseRegisterComicUrl}');

    ModelPreset.termsOfUseTranslateComicUrl = linkJson['terms_of_use_translate_comic'];
    print('parseJson - terms_of_use_translate_comic : ${ModelPreset.termsOfUseTranslateComicUrl}');

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }



}