import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_weekly_creator_info.dart';
import 'package:sparky/models/model_weekly_creator_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';



class PacketC2SWeeklyCreatorInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 0;
  int _fetchStatus = 0;

  PacketC2SWeeklyCreatorInfo()
  {
    type = e_packet_type.c2s_weekly_creator_info;
  }

  void generate()
  {
    //_pageViewCount = pageViewCount;
    //_pageCountIndex = pageCountIndex;
    _fetchStatus = 0;
    respondPacket = null;
    respondPacket = new PacketS2CWeeklyCreatorInfo();
  }

  Future<List<ModelWeeklyCreatorInfo>> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<List<ModelWeeklyCreatorInfo>> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SWeeklyCreatorInfo : fetchFireBaseDB started');

    /*
    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelWeeklyCreatorInfo.list;

      case e_packet_status.none:
        {
          respondPacket.status = e_packet_status.start_dispatch_request;
          break;
        }

      case e_packet_status.start_dispatch_request:
        return null;

      default:
        return null;
    }

    if(e_packet_status.start_dispatch_request == respondPacket.status) {
      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child('model_weekly_creator_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryContinueComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        (respondPacket as PacketS2CWeeklyCreatorInfo).parseFireBaseDBJson(
            snapshot.value, onFetchDone);

        return ModelWeeklyCreatorInfo.list;
      });
    }

     */


    if(3 == _fetchStatus)
      return ModelWeeklyCreatorInfo.list;
    else if(0 == _fetchStatus) {
      _fetchStatus = 1;

      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child('model_weekly_creator_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SWeeklyCreatorInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        _fetchStatus = 2;

        PacketS2CWeeklyCreatorInfo packet = new PacketS2CWeeklyCreatorInfo();
        packet.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;

        return ModelWeeklyCreatorInfo.list;
      });
    }



    return null;
  }

  Future<List<ModelWeeklyCreatorInfo>> _fetchBytes() async
  {
    print('PacketC2SWeeklyCreatorInfo : fetchBytes started');

    if(null != ModelWeeklyCreatorInfo.list)
      return ModelWeeklyCreatorInfo.list;

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
      print('eventList.length : ${eventList.length}');

      int packetSize = byteData.getUint32(0,PacketCommon.endian);
      //print('byteData.getUint32(0) : $packetSize');

      if(eventList.length == packetSize)
      {
        //print('eventList.length == packetSize');

        PacketS2CWeeklyCreatorInfo packet = new PacketS2CWeeklyCreatorInfo();
        packet.parseBytes(packetSize,byteData);
      }

      return ModelWeeklyCreatorInfo.list;
    });


    int packetBodySize = 4 + 4;

    if(0 == generateHeader(packetBodySize)) {
      setUint32(_pageCountIndex);
      setUint32(_pageViewCount);
      socket.add(packet);
    }

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

    return ModelWeeklyCreatorInfo.list;
  }


}