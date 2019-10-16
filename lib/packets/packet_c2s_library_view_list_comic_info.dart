import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_library_view_list_comic_info.dart';
import 'package:sparky/models/model_library_view_list_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';



class PacketC2SLibraryViewListComicInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 0;
  int _fetchStatus = 0;
  bool _wantLoad = false;

  PacketC2SLibraryViewListComicInfo()
  {
    type = e_packet_type.c2s_library_view_list_comic_info;
  }

  void generate()
  {
    //_pageViewCount = pageViewCount;
    //_pageCountIndex = pageCountIndex;
    _fetchStatus = 0;
    respondPacket = null;
    respondPacket = new PacketS2CLibraryViewListComicInfo();
    _wantLoad = true;
  }

  Future<List<ModelLibraryViewListComicInfo>> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<List<ModelLibraryViewListComicInfo>> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SLibraryViewListComicInfo : fetchFireBaseDB started');
    if(false == _wantLoad)
      return ModelLibraryViewListComicInfo.list;

    /*
    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelLibraryViewListComicInfo.list;

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
          .reference.child('model_library_view_list_comic_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryContinueComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        (respondPacket as PacketS2CLibraryViewListComicInfo).parseFireBaseDBJson(snapshot.value, onFetchDone);

        return ModelLibraryViewListComicInfo.list;
      });
    }

     */




    if(3 == _fetchStatus)
      return ModelLibraryViewListComicInfo.list;
    else if(0 == _fetchStatus) {
      _fetchStatus = 1;

      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child('model_library_view_list_comic_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryViewListComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        _fetchStatus = 2;

        PacketS2CLibraryViewListComicInfo packet = new PacketS2CLibraryViewListComicInfo();
        packet.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;

        return ModelLibraryViewListComicInfo.list;
      });
    }

    return null;
  }

  Future<List<ModelLibraryViewListComicInfo>> _fetchBytes(onFetchDone) async
  {
    print('PacketC2SLibraryViewListComicInfo : fetchBytes started');

    if(null != ModelLibraryViewListComicInfo.list)
      return ModelLibraryViewListComicInfo.list;

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

        PacketS2CLibraryViewListComicInfo packet = new PacketS2CLibraryViewListComicInfo();
        packet.parseBytes(packetSize,byteData,onFetchDone);
      }

      return ModelLibraryViewListComicInfo.list;
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


    return ModelLibraryViewListComicInfo.list;
  }


}