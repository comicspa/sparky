import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_utility.dart';


class PacketS2CCommon extends PacketCommon
{
  int _systemErrorCode;
  int _serviceErrorCode;

  int get systemErrorCode => _systemErrorCode;
  int get serviceErrorCode => _serviceErrorCode;

  set systemErrorCode(int systemErrorCode)
  {
    _systemErrorCode = systemErrorCode;
  }

  set serviceErrorCode(int serviceErrorCode)
  {
    _serviceErrorCode = serviceErrorCode;
  }

  bool parseHeader(List<int> event)
  {
    packet = Uint8List.fromList(event);
    byteData = ByteData.view(packet.buffer);

    size = getUint32();
    type = e_packet_type.values[getUint16()];

    return true;
  }

  bool parseHeaderChecked(int packetSize,ByteData byteDataExceptionSize)
  {
    byteData = byteDataExceptionSize;

    size = packetSize;
    currentOffset += 4;
    type = e_packet_type.values[getUint16()];

    return true;
  }


  int getUint32()
  {
    int value = byteData.getUint32(currentOffset, PacketCommon.endian);
    currentOffset += 4;
    return value;
  }


  int getUint16()
  {
    int value = byteData.getUint16(currentOffset, PacketCommon.endian);
    currentOffset += 2;
    return value;
  }

  double getDouble()
  {
    double value = byteData.getFloat64(currentOffset, PacketCommon.endian);
    currentOffset += 8;
    return value;
  }


  String readStringToByteBuffer()
  {
    Map<int,String> map = PacketUtility.readStringFromByteBuffer(byteData, currentOffset,PacketCommon.endian);
    currentOffset = map.keys.elementAt(0);
    String stringName = map.values.elementAt(0);
    return stringName;
  }



}