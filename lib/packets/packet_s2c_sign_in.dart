import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';

class PacketS2CSignIn extends PacketC2SCommon
{

  PacketS2CSignIn()
  {
    type = e_packet_type.s2c_sign_in;
  }

  Future<void> parseFireBaseDBJson(onFetchDone) async
  {


    if(null != onFetchDone)
      onFetchDone(this);
  }
}