import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CRegisterCreator extends PacketS2CCommon
{
  PacketS2CRegisterCreator()
  {
    type = e_packet_type.s2c_register_creator;
  }

  void parseBytes(List<int> event)
  {
    parseHeader(event);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PacketSize : $size , PacketType : $type');

  }

}