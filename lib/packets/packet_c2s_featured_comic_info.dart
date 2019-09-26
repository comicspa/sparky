import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_featured_comic_info.dart';
import 'package:sparky/models/model_featured_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';



class PacketC2SFeaturedComicInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 0;

  PacketC2SFeaturedComicInfo()
  {
    type = e_packet_type.c2s_featured_comic_info;
  }

  void generate(int pageViewCount,int pageCountIndex)
  {
    _pageViewCount = pageViewCount;
    _pageCountIndex = pageCountIndex;
  }

  Future<List<ModelFeaturedComicInfo>> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<List<ModelFeaturedComicInfo>> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SFeaturedComicInfo : fetchFireBaseDB started');

    if(null != ModelFeaturedComicInfo.list)
      return ModelFeaturedComicInfo.list;

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_featured_comic_info');
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('[PacketC2SFeaturedComicInfo:fetchFireBaseDB ] - ${snapshot.value}');

      PacketS2CFeaturedComicInfo packet = new PacketS2CFeaturedComicInfo();
      packet.parseFireBaseDBJson(snapshot.value , onFetchDone);

      return ModelFeaturedComicInfo.list;

    });

    return null;
  }


  Future<List<ModelFeaturedComicInfo>> fetchBytes(onFetchDone) async
  {
    print('PacketC2SFeaturedComicInfo : fetchBytes started');

    if(null != ModelFeaturedComicInfo.list)
       return ModelFeaturedComicInfo.list;

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

        PacketS2CFeaturedComicInfo packet = new PacketS2CFeaturedComicInfo();
        packet.parseBytes(packetSize,byteData,onFetchDone);
        return ModelFeaturedComicInfo.list;
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