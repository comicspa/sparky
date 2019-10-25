
import 'dart:typed_data';


import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketC2SCommon extends PacketCommon
{
  PacketS2CCommon _respondPacket;

  PacketS2CCommon get respondPacket => _respondPacket;
  set respondPacket(PacketS2CCommon respondPacket)
  {
    _respondPacket = respondPacket;
  }

  e_packet_status getRespondStatus()
  {
    return _respondPacket.status;
  }

  int generateHeader(int packetBodySize)
  {
    if(null != packet)
      return 1;

    this.size += packetBodySize;
    print('packetSize : ${this.size} , packetType : ${this.type}');

    packet = Uint8List(this.size);
    byteData = ByteData.view(packet.buffer);

    setUint32(this.size);
    setUint16(this.type.index);

    return 0;
  }


  int resetHeader(int packetBodySize)
  {
    this.size = 4 + 2;
    this.size += packetBodySize;
    print('packetSize : ${this.size} , packetType : ${this.type}');


    packet = null;
    packet = Uint8List(this.size);
    byteData = null;
    byteData = ByteData.view(packet.buffer);

    currentOffset = 0;
    setUint32(this.size);
    setUint16(this.type.index);

    return 0;
  }

  void clear()
  {

  }


  bool setUint32(int value)
  {
    if(null == byteData)
      return false;

    byteData.setUint32(currentOffset, value, PacketCommon.endian);
    currentOffset += 4;

    return true;
  }


  bool setUint16(int value)
  {
    if(null == byteData)
      return false;

    byteData.setUint16(currentOffset,value, PacketCommon.endian);
    currentOffset += 2;

    return true;
  }


  bool setDouble(double value)
  {
    if(null == byteData)
      return false;

    byteData.setFloat64(currentOffset,value, PacketCommon.endian);
    currentOffset += 8;

    return true;
  }



  void writeStringToByteBuffer(List<int> fileNameStringEncodedList)
  {
    currentOffset = PacketUtility.writeStringToByteBuffer(byteData, currentOffset, fileNameStringEncodedList, PacketCommon.endian);
  }


  void writeImageToByteBuffer(ByteData imageByteData)
  {
    currentOffset = PacketUtility.writeImageToByteBuffer(byteData,imageByteData,currentOffset,PacketCommon.endian);
  }


  List<int> readyWriteStringToByteBuffer(String str)
  {
    return PacketUtility.readyWriteStringToByteBuffer(str);
  }



  int getStringTotalLength(List<int> intList)
  {
    return PacketUtility.getStringTotalLength(intList);
  }



}