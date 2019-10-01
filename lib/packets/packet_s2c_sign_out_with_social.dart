import 'dart:typed_data';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CSignOutWithSocial extends PacketS2CCommon
{
  PacketS2CSignOutWithSocial()
  {
    type = e_packet_type.s2c_sign_out_with_social;
  }


  Future<void> parseGoogle(onFetchDone) async
  {

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