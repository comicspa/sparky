
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_preset_comic_info.dart';




class PacketC2SPresetComicInfo extends PacketC2SCommon
{
  PacketC2SPresetComicInfo()
  {
    type = e_packet_type.c2s_preset_comic_info;
  }

  void generate()
  {

  }

  Future<void> fetchBytes() async
  {
    print('PacketC2SPresetLibraryInfo : fetchBytes started');

    try {
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    final List<int> eventList = new List<int>();
    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      //print('socket.listen : ${event.length}');
      eventList.addAll(event);
      //print('socket.listen : ${eventList.length}');

      var packet = Uint8List.fromList(eventList);
      ByteData byteData = ByteData.view(packet.buffer);
      //print('eventList.length : ${eventList.length}');

      int packetSize = byteData.getUint32(0,PacketCommon.endian);
      //print('byteData.getUint32(0) : $packetSize');

      if(eventList.length == packetSize)
      {
        //print('eventList.length == packetSize');

        PacketS2CPresetComicInfo packet = new PacketS2CPresetComicInfo();
        packet.parseBytes(packetSize,byteData);


      }


    });


    int packetBodySize  = 0;
    if(0 == generateHeader(packetBodySize))
    {
      socket.add(packet);
    }

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();
    } catch(exception, stackTrace) {
      print(exception);
    }


  }


}