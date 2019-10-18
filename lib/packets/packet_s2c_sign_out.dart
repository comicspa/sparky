import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_user_info.dart';


class PacketS2CSignOut extends PacketS2CCommon
{

  PacketS2CSignOut()
  {
    type = e_packet_type.s2c_sign_out;
  }

  Future<void> parseFireBaseDBJson(onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;
    ModelUserInfo.getInstance().signOut();

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }
}