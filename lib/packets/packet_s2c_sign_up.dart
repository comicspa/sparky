import 'dart:typed_data';

import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/manage/manage_shared_preference.dart';

class PacketS2CSignUp extends PacketS2CCommon
{
  PacketS2CSignUp()
  {
    type = e_packet_type.s2c_sign_up;
  }


  Future<void> parseFireBaseDBJson(onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;

    ManageSharedPreference.setString('uId',ModelUserInfo.getInstance().uId);
    ManageSharedPreference.setInt('social_provider_type',ModelUserInfo.getInstance().socialProviderType.index);

    ModelUserInfo.getInstance().signedIn = true;

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }



  void parseBytes(List<int> event)
  {
    parseHeader(event);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type');

  }

}