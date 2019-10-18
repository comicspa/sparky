import 'dart:typed_data';

import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CRegisterCreator extends PacketS2CCommon
{
  PacketS2CRegisterCreator()
  {
    type = e_packet_type.s2c_register_creator;
  }


  Future<void> parseFireBaseDBJson(onFetchDone,String creatorId) async
  {
    status = e_packet_status.start_dispatch_respond;
    ModelUserInfo.getInstance().searchAddCreator(creatorId);


    status = e_packet_status.finish_dispatch_respond;
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