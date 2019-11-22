import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_new_comic_info.dart';
import 'package:sparky/models/model_new_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class PacketC2SNewComicInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 0;
  int _fetchStatus = 0;
  bool _wantLoad = false;
  int _databaseType = 1;

  PacketC2SNewComicInfo()
  {
    type = e_packet_type.c2s_new_comic_info;
  }


  void generate({bool recreateList = false})
  {
    _fetchStatus = 0;

    if(null == respondPacket)
      respondPacket = new PacketS2CNewComicInfo();
    else
      respondPacket.reset();

    if(true == recreateList)
    {
      if(null != ModelNewComicInfo.list)
      {
        ModelNewComicInfo.list.clear();
        ModelNewComicInfo.list = null;
      }
    }

    _wantLoad = true;
  }


  Future<List<ModelNewComicInfo>> fetch(onFetchDone) async
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


  Future<List<ModelNewComicInfo>> _fetchFireStoreDB(onFetchDone) async
  {
    print('PacketC2SNewComicInfo : _fetchFireStoreDB started');

    if (null != ModelNewComicInfo.list)
      return ModelNewComicInfo.list;

    print('aaaa : ${respondPacket.status.toString()}');
    if(e_packet_status.none == respondPacket.status)
    {
      print('bbbb');
      respondPacket.status = e_packet_status.start_dispatch_request;

      List<ModelNewComicInfo> list;
      await ManageFireBaseCloudFireStore.getQuerySnapshot(ModelNewComicInfo.ModelName).then((QuerySnapshot snapshot)
      {
        respondPacket.status = e_packet_status.wait_respond;

        for (int countIndex = 0; countIndex < snapshot.documents.length; ++countIndex)
        {
          var map = snapshot.documents[countIndex].data;

          ModelNewComicInfo modelNewComicInfo = new ModelNewComicInfo();
          modelNewComicInfo.comicNumber = map['comic_number'];;
          modelNewComicInfo.creatorId = map['creator_id'];
          modelNewComicInfo.partNumber = map['part_number'];
          modelNewComicInfo.seasonNumber = map['season_number'];

          //print('comicNumber : ${modelFeaturedComicInfo.comicNumber}');
          //print('creatorId : ${modelFeaturedComicInfo.creatorId}');
          //print('partNumber : ${modelFeaturedComicInfo.partNumber}');
          //print('seasonNumber : ${modelFeaturedComicInfo.seasonNumber}');

          if (null == list)
            list = new List<ModelNewComicInfo>();
          list.add(modelNewComicInfo);

        }
      });


      if(null != list)
      {
        for(int countIndex=0; countIndex<list.length; ++countIndex)
        {
          ModelNewComicInfo modelNewComicInfo = list[countIndex];

          print('comicId : ${modelNewComicInfo.comicId}');

          await ManageFireBaseCloudFireStore.getDocumentSnapshot(ModelComicInfo.ModelName,modelNewComicInfo.comicId).then((documentSnapshot)
          {
            print('document : ${documentSnapshot.data.toString()}');

            modelNewComicInfo.titleName = documentSnapshot.data['title_name'];
            modelNewComicInfo.creatorName = documentSnapshot.data['creator_name1'] + '/' + documentSnapshot.data['creator_name2'];

            if (list.length - 1 == countIndex)
            {
              print('list.length - 1 == countIndex');

              if (null == respondPacket)
                respondPacket = new PacketS2CNewComicInfo();
              respondPacket.status = e_packet_status.finish_dispatch_respond;

              ModelNewComicInfo.list = list;

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


  ///
  Future<List<ModelNewComicInfo>> _fetchRealTimeDB(onFetchDone) async
  {
    print('PacketC2SNewComicInfo : _fetchRealTimeDB started');
    if(false == _wantLoad)
      return ModelNewComicInfo.list;

    /*
    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelNewComicInfo.list;

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
          .reference.child('model_new_comic_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryContinueComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        (respondPacket as PacketS2CNewComicInfo).parseFireBaseDBJson(snapshot.value, onFetchDone);

        return ModelNewComicInfo.list;
      });
    }
     */



    if(3 == _fetchStatus)
      return ModelNewComicInfo.list;
    else if(0 == _fetchStatus) {
      _fetchStatus = 1;

      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child(ModelNewComicInfo.ModelName);
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SNewComicInfo:fetchFireBaseDB ] - ${snapshot.value}');

        _fetchStatus = 2;

        PacketS2CNewComicInfo packet = new PacketS2CNewComicInfo();
        packet.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;

        return ModelNewComicInfo.list;
      });
    }



    return null;
  }


  Future<List<ModelNewComicInfo>> _fetchBytes() async
  {
    print('PacketC2SNewComicInfo : fetchBytes started');

    if(null != ModelNewComicInfo.list)
      return ModelNewComicInfo.list;

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

        PacketS2CNewComicInfo packet = new PacketS2CNewComicInfo();
        packet.parseBytes(packetSize,byteData);
      }

      return ModelNewComicInfo.list;
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

    return ModelNewComicInfo.list;
  }


}