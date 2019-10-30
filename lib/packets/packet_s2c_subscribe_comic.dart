
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CSubscribeComic extends PacketS2CCommon
{
  PacketS2CSubscribeComic()
  {
    type = e_packet_type.s2c_subscribe_comic;
  }

  Future<void> parseFireBaseDBJson(int subscribed , onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;

    ModelComicDetailInfo.getInstance().subscribed = subscribed;

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }








}