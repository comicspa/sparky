import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_weekly_trend_comic_info.dart';
import 'package:sparky/models/model_weekly_trend_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';



class PacketC2SWeeklyTrendComicInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 0;

  PacketC2SWeeklyTrendComicInfo()
  {
    type = e_packet_type.c2s_weekly_trend_comic_info;
  }

  void generate(int pageViewCount,int pageCountIndex)
  {
    _pageViewCount = pageViewCount;
    _pageCountIndex = pageCountIndex;
  }

  Future<List<ModelWeeklyTrendComicInfo>> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<List<ModelWeeklyTrendComicInfo>> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SWeeklyTrendComicInfo : fetchFireBaseDB started');

    if(null != ModelWeeklyTrendComicInfo.list)
      return ModelWeeklyTrendComicInfo.list;

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_weekly_trend_comic_info');
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('[PacketC2SWeeklyTrendComicInfo:fetchFireBaseDB ] - ${snapshot.value}');

      PacketS2CWeeklyTrendComicInfo packet = new PacketS2CWeeklyTrendComicInfo();
      packet.parseFireBaseDBJson(snapshot.value , onFetchDone);

      return ModelWeeklyTrendComicInfo.list;

    });

    return null;
  }

  Future<List<ModelWeeklyTrendComicInfo>> _fetchBytes() async
  {
    print('PacketC2SWeeklyPopularComicInfo : fetchBytes started');

    if(null != ModelWeeklyTrendComicInfo.list)
      return ModelWeeklyTrendComicInfo.list;

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

        PacketS2CWeeklyTrendComicInfo packet = new PacketS2CWeeklyTrendComicInfo();
        packet.parseBytes(packetSize,byteData);
      }

      return ModelWeeklyTrendComicInfo.list;
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

    return ModelWeeklyTrendComicInfo.list;
  }


}