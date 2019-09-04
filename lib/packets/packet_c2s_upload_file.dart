import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_s2c_upload_file.dart';


typedef void OnPacketUploadFileFetchDone(PacketS2CUploadFile packet);


class PacketC2SUploadFile extends PacketCommon
{
  String _pathName;
  String _fileFullName;
  int _userId;
  int _creatorId;


  PacketC2SUploadFile()
  {
    type = e_packet_type.c2s_upload_file;
  }

  void generate(String pathName,String fileFullName,int userId,int creatorId)
  {
      _pathName = pathName;
      _fileFullName = fileFullName;
      _userId = userId;
      _creatorId = creatorId;
  }

  void fetchBytes(onPacketUploadFileFetchDone) async
  {
    ///////////////////////////////////////////////////////////////////////////////////////
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CUploadFile packet = new PacketS2CUploadFile();
      packet.parseBytes(event);
      onPacketUploadFileFetchDone(packet);
    });


    String filePathFullName = '$_pathName/$_fileFullName';

    ByteData imageByteData = null;

    imageByteData = await rootBundle.load('images/$_fileFullName');
   //imageByteData = await Preset.getByteDataFromFile(filePathFullName);

    int lengthInBytes = imageByteData.lengthInBytes;
    print('lengthInBytes : $lengthInBytes');

    List<int> fileNameStringEncodedList = PacketUtility.readyWriteStringToByteBuffer(_fileFullName);

    this.size = 4 + 2 + 4 + 4 + (4 + fileNameStringEncodedList.length * 4) + (4 + lengthInBytes);
    print('packetSize : ${this.size}');

    var sendPacket = Uint8List(this.size);
    var sendByteData = ByteData.view(sendPacket.buffer);

    sendByteData.setUint32(0, this.size, Endian.little);
    sendByteData.setUint16(4, this.type.index, Endian.little);
    sendByteData.setUint32(6, _userId,Endian.little);
    sendByteData.setUint32(10, _creatorId,Endian.little);

    int currentOffset = 14;
    currentOffset = PacketUtility.writeStringToByteBuffer(sendByteData, currentOffset, fileNameStringEncodedList, Endian.little);
    currentOffset = PacketUtility.writeImageToByteBuffer(sendByteData,imageByteData,currentOffset,Endian.little);

    socket.add(sendPacket);

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 20));
    socket.close();
  }


  static void usage()
  {

  }

}