import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/models/model_user_info.dart';

class PacketS2CSignIn extends PacketC2SCommon
{

  PacketS2CSignIn()
  {
    type = e_packet_type.s2c_sign_in;
  }

  Future<void> parseFireBaseDBJson(onFetchDone) async
  {

    ModelUserInfo.getInstance().signedIn = true;


    if(null != onFetchDone)
      onFetchDone(this);
  }
}