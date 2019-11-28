import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_today_trend_comic_info.dart';
import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class PacketC2STodayTrendComicInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 1;
  int _fetchStatus = 0;
  bool _wantLoad = false;
  int _databaseType = 1;

  PacketC2STodayTrendComicInfo()
  {
    type = e_packet_type.c2s_today_trend_comic_info;
  }

  void generate(OnFetchDone onFetchDone,{bool recreateList = false})
  {
    _fetchStatus = 0;
    this.onFetchDone = onFetchDone;
    ModelTodayTrendComicInfo.status = e_packet_status.start_dispatch_request;

    if(null == respondPacket)
      respondPacket = new PacketS2CTodayTrendComicInfo();
    else
      respondPacket.reset();

    if(true == recreateList)
    {
      if(null != ModelTodayTrendComicInfo.list)
      {
        ModelTodayTrendComicInfo.list.clear();
        ModelTodayTrendComicInfo.list = null;
      }
    }

    _wantLoad = true;
  }


  Future<List<ModelTodayTrendComicInfo>> fetch(onFetchDone) async
  {
    switch(_databaseType)
    {
      case 0:
        return _fetchRealTimeDB(onFetchDone);

      case 1:
        return _fetchFireStoreDB(onFetchDone);

      default:
        break;
    }

    return null;
  }


  Future<List<ModelTodayTrendComicInfo>> _fetchFireStoreDB(onFetchDone) async
  {
    print('PacketC2STodayTrendComicInfo : _fetchFireStoreDB started');

    if(e_packet_status.none == ModelTodayTrendComicInfo.status || e_packet_status.finish_dispatch_respond == ModelTodayTrendComicInfo.status)
      return ModelTodayTrendComicInfo.list;

    print('aaaa : ${respondPacket.status.toString()}');
    if(e_packet_status.none == respondPacket.status)
    {
      print('bbbb');
      respondPacket.status = e_packet_status.start_dispatch_request;
      ModelTodayTrendComicInfo.status = e_packet_status.start_dispatch_request;

      List<ModelTodayTrendComicInfo> list;
      await ManageFireBaseCloudFireStore.getQuerySnapshot(ModelTodayTrendComicInfo.ModelName).then((QuerySnapshot snapshot)
      {
        respondPacket.status = e_packet_status.wait_respond;
        ModelTodayTrendComicInfo.status = e_packet_status.wait_respond;

        for (int countIndex = 0; countIndex < snapshot.documents.length; ++countIndex)
        {
          var map = snapshot.documents[countIndex].data;

          ModelTodayTrendComicInfo modelTodayTrendComicInfo = new ModelTodayTrendComicInfo();
          modelTodayTrendComicInfo.comicNumber = map['comic_number'];;
          modelTodayTrendComicInfo.creatorId = map['creator_id'];
          modelTodayTrendComicInfo.partNumber = map['part_number'];
          modelTodayTrendComicInfo.seasonNumber = map['season_number'];

          //print('comicNumber : ${modelFeaturedComicInfo.comicNumber}');
          //print('creatorId : ${modelFeaturedComicInfo.creatorId}');
          //print('partNumber : ${modelFeaturedComicInfo.partNumber}');
          //print('seasonNumber : ${modelFeaturedComicInfo.seasonNumber}');

          if (null == list)
            list = new List<ModelTodayTrendComicInfo>();
          list.add(modelTodayTrendComicInfo);

        }
      });


      if(null != list)
      {
        for(int countIndex=0; countIndex<list.length; ++countIndex)
        {
          ModelTodayTrendComicInfo modelTodayTrendComicInfo = list[countIndex];

          print('comicId : ${modelTodayTrendComicInfo.comicId}');

          await ManageFireBaseCloudFireStore.getDocumentSnapshot(ModelComicInfo.ModelName,modelTodayTrendComicInfo.comicId).then((documentSnapshot)
          {
            print('document : ${documentSnapshot.data.toString()}');

            modelTodayTrendComicInfo.titleName = documentSnapshot.data['title_name'];
            modelTodayTrendComicInfo.creatorName = documentSnapshot.data['creator_name1'] + '/' + documentSnapshot.data['creator_name2'];

            if (list.length - 1 == countIndex)
            {
              print('[PacketC2STodayTrendComicInfo : _fetchFireStoreDB] - list.length - 1 == countIndex');

              if (null == respondPacket)
                respondPacket = new PacketS2CTodayTrendComicInfo();
              respondPacket.status = e_packet_status.finish_dispatch_respond;
              ModelTodayTrendComicInfo.status = e_packet_status.finish_dispatch_respond;

              ModelTodayTrendComicInfo.list = list;

              if (null != this.onFetchDone)
                this.onFetchDone(respondPacket);

            }
          });

        }
      }
    }

    return null;
  }


  Future<List<ModelTodayTrendComicInfo>> _fetchRealTimeDB(onFetchDone) async
  {
    print('PacketC2STodayTrendComicInfo : fetchFireBaseDB started');
    if(false == _wantLoad)
      return ModelTodayTrendComicInfo.list;

    /*
    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelTodayTrendComicInfo.list;

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
          .reference.child('model_today_trend_comic_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryContinueComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        (respondPacket as PacketS2CTodayTrendComicInfo).parseFireBaseDBJson(
            snapshot.value, onFetchDone);

        return ModelTodayTrendComicInfo.list;
      });
    }

     */


    if(3 == _fetchStatus)
      return ModelTodayTrendComicInfo.list;
    else if(0 == _fetchStatus) {
      _fetchStatus = 1;


      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child('model_today_trend_comic_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2STodayTrendComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        _fetchStatus = 2;

        PacketS2CTodayTrendComicInfo packet = new PacketS2CTodayTrendComicInfo();
        packet.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;

        return ModelTodayTrendComicInfo.list;
      });
    }



    return null;
  }


  Future<List<ModelTodayTrendComicInfo>> _fetchBytes() async
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