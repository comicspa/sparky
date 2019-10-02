import 'dart:typed_data';

import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/manage/manage_shared_preference.dart';
import 'package:sparky/manage/manage_firebase_auth.dart';

class PacketS2CWithdrawal extends PacketS2CCommon
{
  PacketS2CWithdrawal()
  {
    type = e_packet_type.s2c_withdrawal;
  }

  Future<void> parseFireBaseDBJson(onFetchDone) async
  {
    ManageSharedPreference.remove('uId');
    ManageSharedPreference.remove('social_provider_type');

    ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.none;
    ModelUserInfo.getInstance().displayName = null;
    ModelUserInfo.getInstance().photoUrl = null;
    ModelUserInfo.getInstance().email = null;
    ModelUserInfo.getInstance().signedIn = false;
    ModelUserInfo.getInstance().uId = null;

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