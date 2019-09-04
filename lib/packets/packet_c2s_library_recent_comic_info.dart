

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_library_recent_comic_info.dart';
import 'package:sparky/models/model_library_recent_comic_info.dart';



class PacketC2SLibraryRecentComicInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 0;

  PacketC2SLibraryRecentComicInfo()
  {
    type = e_packet_type.c2s_library_recent_comic_info;
  }

  void generate()
  {
    //_pageViewCount = pageViewCount;
    //_pageCountIndex = pageCountIndex;
  }

  Future<List<ModelLibraryRecentComicInfo>> fetchBytes() async
  {
    print('PacketC2SMyLockerComicRecent : fetchBytes started');

    if(null != ModelLibraryRecentComicInfo.list)
      return ModelLibraryRecentComicInfo.list;

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

        PacketS2CLibraryRecentComicInfo packet = new PacketS2CLibraryRecentComicInfo();
        packet.parseBytes(packetSize,byteData);
      }

      return ModelLibraryRecentComicInfo.list;
    });


    int packetBodySize  = 4 + 4;
    if(0 == generateHeader(packetBodySize)) {
      setUint32(_pageCountIndex);
      setUint32(_pageViewCount);

      socket.add(packet);
    }

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

    return ModelLibraryRecentComicInfo.list;
  }


}