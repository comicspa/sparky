import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class PacketUtility
{

  static List<int> readyWriteStringToByteBuffer(String writeString)
  {
    var writeStringEncoded = utf8.encode(writeString);
    List<int> writeStringEncodedList = writeStringEncoded.toList();
    return writeStringEncodedList;
  }


  static int writeStringToByteBuffer(var byteDataBuffer,int currentOffset,List<int> writeStringEncodedList,Endian endian)
  {
    byteDataBuffer.setUint32(currentOffset, writeStringEncodedList.length, endian);
    currentOffset += 4;

    for(int countIndex=0; countIndex<writeStringEncodedList.length; ++countIndex)
    {
      byteDataBuffer.setUint32(currentOffset, writeStringEncodedList[countIndex], endian);
      currentOffset += 4;
    }

    return currentOffset;
  }

  static int getStringTotalLength(List<int> writeStringEncodedList)
  {
    //size + length
    return 4 + writeStringEncodedList.length * 4;
  }


  static Map<int,String> readStringFromByteBuffer(var byteDataBuffer,int currentOffset,Endian endian)
  {
    var length = byteDataBuffer.getUint32(currentOffset, endian);
    currentOffset += 4;

    List<int> readStringList = new List<int>();
    for(int countIndex=0; countIndex<length; ++countIndex)
    {
      readStringList.add(byteDataBuffer.getUint32(currentOffset, endian));
      currentOffset += 4;
    }

    String readString = utf8.decode(readStringList);

    Map<int,String> result = new Map();
    result[currentOffset] = readString;
    return result;
  }

  static int writeImageToByteBuffer(var byteDataBuffer,ByteData imageByteData,int currentOffset,Endian endian)
  {
    int lengthInBytes = imageByteData.lengthInBytes;
    print('writeImageToByteBuffer - lengthInBytes : $lengthInBytes');

    byteDataBuffer.setUint32(currentOffset, lengthInBytes, endian);
    currentOffset += 4;

    for(int countIndex=0; countIndex<lengthInBytes; ++countIndex)
    {
      byteDataBuffer.setUint8(currentOffset,imageByteData.getUint8(countIndex));
      currentOffset ++;
    }

    return currentOffset;
  }


  static int getImageTotalLength(ByteData imageByteData)
  {
    return 4 + imageByteData.lengthInBytes;
  }



}