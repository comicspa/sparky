
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CStorageFileRealUrl extends PacketS2CCommon
{
  PacketS2CStorageFileRealUrl()
  {
    type = e_packet_type.s2c_storage_file_real_url;
  }


  Future<void> parseFireBaseDBJson(onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;






    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }




}