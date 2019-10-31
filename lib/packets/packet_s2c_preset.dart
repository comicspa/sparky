import 'dart:typed_data';
import 'dart:convert';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PacketS2CPreset extends PacketS2CCommon
{
  PacketS2CPreset()
  {
    type = e_packet_type.s2c_preset;
  }

  void parseInfo(Map<dynamic,dynamic> jsonMap)
  {
    String version = jsonMap['version'];
    print('parseInfo - current version : $version , app version : ${ModelPreset.version}');
  }

  void parseLink(Map<dynamic,dynamic> jsonMap)
  {
    ModelPreset.faqUrl = jsonMap['faq'];
    print('parseLink - faq : ${ModelPreset.faqUrl}');

    ModelPreset.privacyPolicyUrl = jsonMap['privacy_policy'];
    print('parseLink - privacy_policy : ${ModelPreset.privacyPolicyUrl}');

    ModelPreset.termsOfUseUrl = jsonMap['terms_of_use'];
    print('parseLink - terms_of_use : ${ModelPreset.termsOfUseUrl}');

    ModelPreset.homepageUrl = jsonMap['home_page'];
    print('parseLink - homepageUrl : ${ModelPreset.homepageUrl}');

    ModelPreset.termsOfUseRegisterComicUrl = jsonMap['terms_of_use_register_comic'];
    print('parseLink - terms_of_use_register_comic : ${ModelPreset.termsOfUseRegisterComicUrl}');

    ModelPreset.termsOfUseTranslateComicUrl = jsonMap['terms_of_use_translate_comic'];
    print('parseLink - terms_of_use_translate_comic : ${ModelPreset.termsOfUseTranslateComicUrl}');
  }


  Future<void> parseRealtimeDatabaseJson(Map<dynamic,dynamic> jsonMap , onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;
    parseInfo(jsonMap);

    var linkJson = jsonMap['link'];
    parseLink(linkJson);

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }


  Future<void> parseCloudFirestoreJson(List<DocumentSnapshot> jsonList , onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;
    for(int i=0; i<jsonList.length; ++i)
    {
      switch(jsonList[i].documentID)
      {
        case 'info':
          {
            parseInfo(jsonList[i].data);
          }
          break;

        case 'link':
          {
            parseLink(jsonList[i].data);
          }
          break;
      }
    }

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }

}