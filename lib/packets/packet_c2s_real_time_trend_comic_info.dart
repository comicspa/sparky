import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_real_time_trend_comic_info.dart';
import 'package:sparky/models/model_real_time_trend_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PacketC2SRealTimeTrendComicInfo extends PacketC2SCommon
{
  int _fetchStatus = 0;
  bool _wantLoad = false;
  int _databaseType = 1;

  PacketC2SRealTimeTrendComicInfo()
  {
    type = e_packet_type.c2s_real_time_trend_comic_info;
  }

  void generate({bool recreateList = false})
  {
    _fetchStatus = 0;

    if(null == respondPacket)
      respondPacket = new PacketS2CRealTimeTrendComicInfo();
    else
      respondPacket.reset();

    if(true == recreateList)
    {
      if(null != ModelRealTimeTrendComicInfo.list)
      {
        ModelRealTimeTrendComicInfo.list.clear();
        ModelRealTimeTrendComicInfo.list = null;
      }
    }

    _wantLoad = true;
  }



  Future<List<ModelRealTimeTrendComicInfo>> fetch(onFetchDone) async
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


  Future<List<ModelRealTimeTrendComicInfo>> _fetchFireStoreDB(onFetchDone) async
  {
    print('PacketC2SRealTimeTrendComicInfo : _fetchFireStoreDB started');

    if (null != ModelRealTimeTrendComicInfo.list)
      return ModelRealTimeTrendComicInfo.list;

    print('aaaa : ${respondPacket.status.toString()}');
    if(e_packet_status.none == respondPacket.status)
    {
      print('bbbb');
      respondPacket.status = e_packet_status.start_dispatch_request;

      List<ModelRealTimeTrendComicInfo> list;
      await ManageFireBaseCloudFireStore.getQuerySnapshot(ModelRealTimeTrendComicInfo.ModelName).then((QuerySnapshot snapshot)
      {
        respondPacket.status = e_packet_status.wait_respond;

        for (int countIndex = 0; countIndex < snapshot.documents.length; ++countIndex)
        {
          var map = snapshot.documents[countIndex].data;

          ModelRealTimeTrendComicInfo modelRealTimeTrendComicInfo = new ModelRealTimeTrendComicInfo();
          modelRealTimeTrendComicInfo.comicNumber = map['comic_number'];;
          modelRealTimeTrendComicInfo.creatorId = map['creator_id'];
          modelRealTimeTrendComicInfo.partNumber = map['part_number'];
          modelRealTimeTrendComicInfo.seasonNumber = map['season_number'];

          //print('comicNumber : ${modelFeaturedComicInfo.comicNumber}');
          //print('creatorId : ${modelFeaturedComicInfo.creatorId}');
          //print('partNumber : ${modelFeaturedComicInfo.partNumber}');
          //print('seasonNumber : ${modelFeaturedComicInfo.seasonNumber}');

          if (null == list)
            list = new List<ModelRealTimeTrendComicInfo>();
          list.add(modelRealTimeTrendComicInfo);

        }
      });


      if(null != list)
      {
        for(int countIndex=0; countIndex<list.length; ++countIndex)
        {
          ModelRealTimeTrendComicInfo modelRealTimeTrendComicInfo = list[countIndex];

          print('comicId : ${modelRealTimeTrendComicInfo.comicId}');

          await ManageFireBaseCloudFireStore.getDocumentSnapshot(ModelComicInfo.ModelName,modelRealTimeTrendComicInfo.comicId).then((documentSnapshot)
          {
            print('document : ${documentSnapshot.data.toString()}');

            modelRealTimeTrendComicInfo.titleName = documentSnapshot.data['title_name'];
            modelRealTimeTrendComicInfo.creatorName = documentSnapshot.data['creator_name1'] + '/' + documentSnapshot.data['creator_name2'];

            if (list.length - 1 == countIndex)
            {
              print('list.length - 1 == countIndex');

              if (null == respondPacket)
                respondPacket = new PacketS2CRealTimeTrendComicInfo();
              respondPacket.status = e_packet_status.finish_dispatch_respond;

              ModelRealTimeTrendComicInfo.list = list;

              if (null != onFetchDone)
                onFetchDone(respondPacket);

            }
          });


        }
      }
    }

    //print('finished');
    return null;
  }


  Future<List<ModelRealTimeTrendComicInfo>> _fetchRealTimeDB(onFetchDone) async
  {
    print('PacketC2SRealTimeTrendComicInfo : _fetchRealTimeDB started');
    if(false == _wantLoad)
      return ModelRealTimeTrendComicInfo.list;

    /*
    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelRealTimeTrendComicInfo.list;

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
          .reference.child(ModelRealTimeTrendComicInfo.ModelName);
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryContinueComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        (respondPacket as PacketS2CRealTimeTrendComicInfo).parseFireBaseDBJson(
            snapshot.value, onFetchDone);

        return ModelRealTimeTrendComicInfo.list;
      });
    }*/


    if(3 == _fetchStatus)
      return ModelRealTimeTrendComicInfo.list;
    else if(0 == _fetchStatus) {
      _fetchStatus = 1;

      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child(ModelRealTimeTrendComicInfo.ModelName);
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SRealTimeTrendComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        _fetchStatus = 2;

        PacketS2CRealTimeTrendComicInfo packet = new PacketS2CRealTimeTrendComicInfo();
        packet.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;

        return ModelRealTimeTrendComicInfo.list;
      });
    }



    return null;
  }

  Future<List<ModelRealTimeTrendComicInfo>> _fetchBytes() async
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
        //setUint32(_pageCountIndex);
        //setUint32(_pageViewCount);
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