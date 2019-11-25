import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_featured_comic_info.dart';
import 'package:sparky/models/model_featured_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PacketC2SFeaturedComicInfo extends PacketC2SCommon
{
  int _fetchStatus = 0;
  bool _wantLoad = false;
  int _databaseType = 1;


  PacketC2SFeaturedComicInfo()
  {
    type = e_packet_type.c2s_featured_comic_info;
  }


  void generate({bool recreateList = false})
  {
    _fetchStatus = 0;

    if(null == respondPacket)
      respondPacket = new PacketS2CFeaturedComicInfo();
    else
      respondPacket.reset();

    if(true == recreateList)
      {
        if(null != ModelFeaturedComicInfo.list)
          {
            ModelFeaturedComicInfo.list.clear();
            ModelFeaturedComicInfo.list = null;
          }
      }

    _wantLoad = true;
  }


  Future<List<ModelFeaturedComicInfo>> fetch(onFetchDone) async
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


  Future<List<ModelFeaturedComicInfo>> _fetchFireStoreDB(onFetchDone) async
  {
    print('PacketC2SFeaturedComicInfo : _fetchFireStoreDB started');

    if (null != ModelFeaturedComicInfo.list)
      return ModelFeaturedComicInfo.list;

    print('aaaa : ${respondPacket.status.toString()}');
    if(e_packet_status.none == respondPacket.status)
    {
      print('bbbb');
      respondPacket.status = e_packet_status.start_dispatch_request;

      List<ModelFeaturedComicInfo> list;
      await ManageFireBaseCloudFireStore.getQuerySnapshot(ModelFeaturedComicInfo.ModelName).then((QuerySnapshot snapshot)
      {
        respondPacket.status = e_packet_status.wait_respond;

        for (int countIndex = 0; countIndex < snapshot.documents.length; ++countIndex)
        {
          var map = snapshot.documents[countIndex].data;

          ModelFeaturedComicInfo modelFeaturedComicInfo = new ModelFeaturedComicInfo();
          modelFeaturedComicInfo.comicNumber = map['comic_number'];;
          modelFeaturedComicInfo.creatorId = map['creator_id'];
          modelFeaturedComicInfo.partNumber = map['part_number'];
          modelFeaturedComicInfo.seasonNumber = map['season_number'];

          //print('comicNumber : ${modelFeaturedComicInfo.comicNumber}');
          //print('creatorId : ${modelFeaturedComicInfo.creatorId}');
          //print('partNumber : ${modelFeaturedComicInfo.partNumber}');
          //print('seasonNumber : ${modelFeaturedComicInfo.seasonNumber}');

          if (null == list)
            list = new List<ModelFeaturedComicInfo>();
          list.add(modelFeaturedComicInfo);

        }
      });


      if(null != list)
      {
        for(int countIndex=0; countIndex<list.length; ++countIndex)
        {
          ModelFeaturedComicInfo modelFeaturedComicInfo = list[countIndex];

          print('comicId : ${modelFeaturedComicInfo.comicId}');

          await ManageFireBaseCloudFireStore.getDocumentSnapshot(ModelComicInfo.ModelName,modelFeaturedComicInfo.comicId).then((documentSnapshot)
          {
            print('document : ${documentSnapshot.data.toString()}');

            modelFeaturedComicInfo.titleName = documentSnapshot.data['title_name'];
            modelFeaturedComicInfo.creatorName = documentSnapshot.data['creator_name1'] + '/' + documentSnapshot.data['creator_name2'];

            if (list.length - 1 == countIndex)
            {
              print('list.length - 1 == countIndex');

              if (null == respondPacket)
                respondPacket = new PacketS2CFeaturedComicInfo();
              respondPacket.status = e_packet_status.finish_dispatch_respond;

              ModelFeaturedComicInfo.list = list;

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



  Future<List<ModelFeaturedComicInfo>> _fetchRealTimeDB(onFetchDone) async
  {
    print('PacketC2SFeaturedComicInfo : _fetchRealTimeDB started');

    if(false == _wantLoad)
      return ModelFeaturedComicInfo.list;

    bool switchFlag = true;
    if(false == switchFlag) {
      if (3 == _fetchStatus)
        return ModelFeaturedComicInfo.list;
      else if (0 == _fetchStatus) {
        _fetchStatus = 1;

        DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
            .reference.child(ModelFeaturedComicInfo.ModelName);
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
    }
    else
      {


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