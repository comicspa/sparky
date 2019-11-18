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
  int _pageCountIndex = 0;
  int _pageViewCount = 0;
  int _fetchStatus = 0;
  bool _wantLoad = false;
  int _databaseType = 1;

  PacketC2SRealTimeTrendComicInfo()
  {
    type = e_packet_type.c2s_real_time_trend_comic_info;
  }

  void generate(int pageViewCount,int pageCountIndex)
  {
    _pageViewCount = pageViewCount;
    _pageCountIndex = pageCountIndex;
    _fetchStatus = 0;
    respondPacket = null;
    respondPacket = new PacketS2CRealTimeTrendComicInfo();
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

    //if(3 == _fetchStatus)
    //  return ModelRecommendedComicInfo.list;
    if(null != ModelRealTimeTrendComicInfo.list)
      return ModelRealTimeTrendComicInfo.list;


    if(0 == _fetchStatus)
    {
      _fetchStatus = 1;

      await ManageFireBaseCloudFireStore.getQuerySnapshot(
          ModelRealTimeTrendComicInfo.ModelName).then((QuerySnapshot snapshot) {
        _fetchStatus = 2;
        for (int countIndex = 0; countIndex <
            snapshot.documents.length; ++countIndex) {
          var map = snapshot.documents[countIndex].data;
          String comicNumber = map['comic_number'];
          String creatorId = map['creator_id'];
          String partNumber = map['part_number'];
          String seasonNumber = map['season_number'];

          ModelRealTimeTrendComicInfo modelRealTimeTrendComicInfo = new ModelRealTimeTrendComicInfo();
          modelRealTimeTrendComicInfo.comicNumber = comicNumber;
          modelRealTimeTrendComicInfo.creatorId = creatorId;
          modelRealTimeTrendComicInfo.partNumber = partNumber;
          modelRealTimeTrendComicInfo.seasonNumber = seasonNumber;

          if (null == ModelRealTimeTrendComicInfo.list)
            ModelRealTimeTrendComicInfo.list =
            new List<ModelRealTimeTrendComicInfo>();
          ModelRealTimeTrendComicInfo.list.add(modelRealTimeTrendComicInfo);

          String comicId = creatorId + '_' + comicNumber + '_' + partNumber +
              '_' + seasonNumber;
          ManageFireBaseCloudFireStore.getDocumentSnapshot(
              ModelComicInfo.ModelName, comicId).then((documentSnapshot) {
            print('document : ${documentSnapshot.data.toString()}');

            modelRealTimeTrendComicInfo.titleName =
            documentSnapshot.data['title_name'];
            modelRealTimeTrendComicInfo.creatorName =
                documentSnapshot.data['creator_name1'] + '/' +
                    documentSnapshot.data['creator_name2'];

            if (snapshot.documents.length - 1 == countIndex) {
              print('snapshot.documents.length - 1 == countIndex');
              _fetchStatus = 3;

              if (null == respondPacket)
                respondPacket = new PacketS2CRealTimeTrendComicInfo();
              respondPacket.status = e_packet_status.finish_dispatch_respond;

              if (null != onFetchDone) {
                onFetchDone(respondPacket);
              }
            }

            /*
            PacketS2CRecommendedComicInfo packet = new PacketS2CRecommendedComicInfo();
            packet.parseCloudFirestoreJson(documentSnapshot.data , onFetchDone);
            return ModelUserInfo.getInstance();
            */

          });
        }
      });
    }

    /*
    if(false == _wantLoad)
      return ModelRecommendedComicInfo.list;

    if(3 == _fetchStatus)
      return ModelRecommendedComicInfo.list;
    else if(0 == _fetchStatus)
    {
      _fetchStatus = 1;

      Firestore.instance.collection(ModelRecommendedComicInfo.ModelName).getDocuments().then((QuerySnapshot snapshot)
      {
        _fetchStatus = 2;
        //snapshot.documents.forEach((f) => print('AAAAAAAAAA : ${f.data}}'));

        PacketS2CRecommendedComicInfo packet = new PacketS2CRecommendedComicInfo();
        packet.parseCloudFirestoreJson(snapshot.documents, onFetchDone);

        _fetchStatus = 3;
        return ModelRecommendedComicInfo.list;

      });
    }
     */

    return ModelRealTimeTrendComicInfo.list;
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