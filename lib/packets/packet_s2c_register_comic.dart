
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CRegisterComic extends PacketS2CCommon
{
  PacketS2CRegisterComic()
  {
    type = e_packet_type.s2c_register_comic;
  }


  Future<void> parseFireBaseDBJson(onFetchDone) async
  {


    if(null != onFetchDone)
      onFetchDone(this);
  }


  void parseBytes(List<int> event)
  {
    parseHeader(event);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PacketSize : $size , PacketType : $type');

  }

}