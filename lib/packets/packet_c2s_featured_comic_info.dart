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
  int _fetchStatus = 0;
  bool _wantLoad = false;

  PacketC2SFeaturedComicInfo()
  {
    type = e_packet_type.c2s_featured_comic_info;
  }

  void generate(int pageViewCount,int pageCountIndex,bool wantLoad)
  {
    _fetchStatus = 0;
    _pageViewCount = pageViewCount;
    _pageCountIndex = pageCountIndex;

    respondPacket = null;
    respondPacket = new PacketS2CFeaturedComicInfo();

    _wantLoad = wantLoad;
  }

  Future<List<ModelFeaturedComicInfo>> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<List<ModelFeaturedComicInfo>> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SFeaturedComicInfo : fetchFireBaseDB started');

    if(false == _wantLoad)
      return ModelFeaturedComicInfo.list;

    /*
    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelFeaturedComicInfo.list;

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

    if(e_packet_status.start_dispatch_request == respondPacket.status)
    {
        DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
            .reference.child('model_featured_comic_info');
        modelUserInfoReference.once().then((DataSnapshot snapshot) {
          print('[PacketC2SFeaturedComicInfo:fetchFireBaseDB ] - ${snapshot
              .value}');

          (respondPacket as PacketS2CFeaturedComicInfo).parseFireBaseDBJson(snapshot.value, onFetchDone);

          return ModelFeaturedComicInfo.list;
        });
    }
*/

    print('_fetchStatus : $_fetchStatus');

    if(3 == _fetchStatus)
      return ModelFeaturedComicInfo.list;
    else if(0 == _fetchStatus)
    {
      _fetchStatus = 1;

      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child('model_featured_comic_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SFeaturedComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        _fetchStatus = 2;

        PacketS2CFeaturedComicInfo packet = new PacketS2CFeaturedComicInfo();
        packet.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;

        return ModelFeaturedComicInfo.list;
      });
    }



    return null;
  }


  Future<List<ModelFeaturedComicInfo>> _fetchBytes(onFetchDone) async
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