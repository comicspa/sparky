import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CEcho extends PacketS2CCommon
{
  String message;

  PacketS2CEcho()
  {
    type = e_packet_type.s2c_echo;

  }

  void clear()
  {
    message = null;
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize, onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    message = readStringToByteBuffer();
    if(null != onFetchDone)
      onFetchDone(this);

  }

}
