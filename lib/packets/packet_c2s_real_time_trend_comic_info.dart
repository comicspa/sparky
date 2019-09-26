import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_real_time_trend_comic_info.dart';
import 'package:sparky/models/model_real_time_trend_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';



class PacketC2SRealTimeTrendComicInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 0;

  PacketC2SRealTimeTrendComicInfo()
  {
    type = e_packet_type.c2s_real_time_trend_comic_info;
  }

  void generate(int pageViewCount,int pageCountIndex)
  {
    _pageViewCount = pageViewCount;
    _pageCountIndex = pageCountIndex;
  }

  Future<List<ModelRealTimeTrendComicInfo>> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<List<ModelRealTimeTrendComicInfo>> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SRealTimeTrendComicInfo : fetchFireBaseDB started');

    if(null != ModelRealTimeTrendComicInfo.list)
      return ModelRealTimeTrendComicInfo.list;

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_real_time_trend_comic_info');
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('[PacketC2SRealTimeTrendComicInfo:fetchFireBaseDB ] - ${snapshot.value}');

      PacketS2CRealTimeTrendComicInfo packet = new PacketS2CRealTimeTrendComicInfo();
      packet.parseFireBaseDBJson(snapshot.value , onFetchDone);

      return ModelRealTimeTrendComicInfo.list;

    });

    return null;
  }

  Future<List<ModelRealTimeTrendComicInfo>> fetchBytes() async
  {
    print('PacketC2SRealTimeTrendInfo : fetchBytes started');

    if(null != ModelRealTimeTrendComicInfo.list)
      return ModelRealTimeTrendComicInfo.list;

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

          PacketS2CRealTimeTrendComicInfo packet = new PacketS2CRealTimeTrendComicInfo();
          packet.parseBytes(packetSize,byteData);
          return ModelRealTimeTrendComicInfo.list;
        }

        return null;
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
    } catch(exception, stackTrace) {
      print(exception);
    }

    return null;
  }


}