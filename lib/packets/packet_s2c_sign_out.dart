import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/models/model_user_info.dart';


class PacketS2CSignOut extends PacketC2SCommon
{

  PacketS2CSignOut()
  {
    type = e_packet_type.s2c_sign_out;
  }

  Future<void> parseFireBaseDBJson(onFetchDone) async
  {

    ModelUserInfo.getInstance().signedIn = false;

    if(null != onFetchDone)
      onFetchDone(this);
  }
}