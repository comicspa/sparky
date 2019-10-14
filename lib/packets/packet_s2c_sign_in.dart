import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_user_info.dart';

class PacketS2CSignIn extends PacketS2CCommon
{

  PacketS2CSignIn()
  {
    type = e_packet_type.s2c_sign_in;
  }

  Future<void> parseFireBaseDBJson(onFetchDone) async
  {

    print('PacketS2CSignIn::parseFireBaseDBJson');

    ModelUserInfo.getInstance().signedIn = true;


    if(null != onFetchDone)
      onFetchDone(this);
  }
}