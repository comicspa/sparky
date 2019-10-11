import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';

class PacketS2CCheckSignUp extends PacketS2CCommon
{

  PacketS2CCheckSignUp()
  {
    type = e_packet_type.s2c_check_sign_up;
  }


  Future<void> parseFireBaseDBJson(Map<dynamic,dynamic> jsonMap,onFetchDone) async
  {

    if(null != jsonMap)
    {
      ModelUserInfo.getInstance().socialProviderType = jsonMap['social_provider_type'];
      ModelUserInfo.getInstance().comi = jsonMap['comi'];
    }

    if(null != onFetchDone)
      onFetchDone(this);
  }





}