import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_today_trend_comic_info.dart';
import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';



class PacketC2STodayTrendComicInfo extends PacketC2SCommon
{
  int _pageCountIndex;
  int _pageViewCount;

  PacketC2STodayTrendComicInfo()
  {
    type = e_packet_type.c2s_today_trend_comic_info;
  }

  void generate(int pageViewCount,int pageCountIndex)
  {
    _pageViewCount = pageViewCount;
    _pageCountIndex = pageCountIndex;
  }

  Future<List<ModelTodayTrendComicInfo>> fetchBytes() async
  {
    print('PacketC2STodayPopularComicInfo : fetchBytes started');

    if(null != ModelTodayTrendComicInfo.list)
      return ModelTodayTrendComicInfo.list;

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

        PacketS2CTodayTrendComicInfo packet = new PacketS2CTodayTrendComicInfo();
        packet.parseBytes(packetSize,byteData);
      }

      return ModelTodayTrendComicInfo.list;
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

    return ModelTodayTrendComicInfo.list;
  }


}