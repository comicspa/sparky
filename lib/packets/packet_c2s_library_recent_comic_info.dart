import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_library_recent_comic_info.dart';
import 'package:sparky/models/model_library_recent_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class PacketC2SLibraryRecentComicInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 0;
  int _fetchStatus = 0;
  bool _wantLoad = false;
  int _databaseType = 1;

  PacketC2SLibraryRecentComicInfo()
  {
    type = e_packet_type.c2s_library_recent_comic_info;
  }

  void generate({bool recreateList = false})
  {
    _fetchStatus = 0;

    if(null == respondPacket)
      respondPacket = new PacketS2CLibraryRecentComicInfo();
    else
      respondPacket.reset();

    if(true == recreateList)
    {
      if(null != ModelLibraryRecentComicInfo.list)
      {
        ModelLibraryRecentComicInfo.list.clear();
        ModelLibraryRecentComicInfo.list = null;
      }
    }

    _wantLoad = true;
  }

  Future<List<ModelLibraryRecentComicInfo>> fetch(onFetchDone) async
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


  Future<List<ModelLibraryRecentComicInfo>> _fetchFireStoreDB(onFetchDone) async
  {
    print('PacketC2SLibraryRecentComicInfo : _fetchFireStoreDB started');

    if (null != ModelLibraryRecentComicInfo.list)
      return ModelLibraryRecentComicInfo.list;

    print('aaaa : ${respondPacket.status.toString()}');
    if(e_packet_status.none == respondPacket.status)
    {
      print('bbbb');
      respondPacket.status = e_packet_status.start_dispatch_request;

      List<ModelLibraryRecentComicInfo> list;
      await ManageFireBaseCloudFireStore.getQuerySnapshot(ModelLibraryRecentComicInfo.ModelName).then((QuerySnapshot snapshot)
      {
        respondPacket.status = e_packet_status.wait_respond;

        for (int countIndex = 0; countIndex < snapshot.documents.length; ++countIndex)
        {
          var map = snapshot.documents[countIndex].data;

          ModelLibraryRecentComicInfo modelLibraryRecentComicInfo = new ModelLibraryRecentComicInfo();
          modelLibraryRecentComicInfo.comicNumber = map['comic_number'];;
          modelLibraryRecentComicInfo.creatorId = map['creator_id'];
          modelLibraryRecentComicInfo.partNumber = map['part_number'];
          modelLibraryRecentComicInfo.seasonNumber = map['season_number'];

          //print('comicNumber : ${modelFeaturedComicInfo.comicNumber}');
          //print('creatorId : ${modelFeaturedComicInfo.creatorId}');
          //print('partNumber : ${modelFeaturedComicInfo.partNumber}');
          //print('seasonNumber : ${modelFeaturedComicInfo.seasonNumber}');

          if (null == list)
            list = new List<ModelLibraryRecentComicInfo>();
          list.add(modelLibraryRecentComicInfo);

        }
      });


      if(null != list)
      {
        for(int countIndex=0; countIndex<list.length; ++countIndex)
        {
          ModelLibraryRecentComicInfo modelLibraryRecentComicInfo = list[countIndex];

          print('comicId : ${modelLibraryRecentComicInfo.comicId}');

          await ManageFireBaseCloudFireStore.getDocumentSnapshot(ModelComicInfo.ModelName,modelLibraryRecentComicInfo.comicId).then((documentSnapshot)
          {
            print('document : ${documentSnapshot.data.toString()}');

            modelLibraryRecentComicInfo.titleName = documentSnapshot.data['title_name'];
            modelLibraryRecentComicInfo.creatorName = documentSnapshot.data['creator_name1'] + '/' + documentSnapshot.data['creator_name2'];

            if (list.length - 1 == countIndex)
            {
              print('[PacketC2SLibraryRecentComicInfo : _fetchFireStoreDB] - list.length - 1 == countIndex');

              if (null == respondPacket)
                respondPacket = new PacketS2CLibraryRecentComicInfo();
              respondPacket.status = e_packet_status.finish_dispatch_respond;

              ModelLibraryRecentComicInfo.list = list;

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


  Future<List<ModelLibraryRecentComicInfo>> _fetchRealTimeDB(onFetchDone) async
  {
    print('PacketC2SLibraryRecentComicInfo : fetchFireBaseDB started');
    if(false == _wantLoad)
      return ModelLibraryRecentComicInfo.list;

    /*
    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelLibraryRecentComicInfo.list;

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
          .reference.child('model_library_recent_comic_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryContinueComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        (respondPacket as PacketS2CLibraryRecentComicInfo).parseFireBaseDBJson(snapshot.value, onFetchDone);

        return ModelLibraryRecentComicInfo.list;
      });
    }

     */



    if(3 == _fetchStatus)
      return ModelLibraryRecentComicInfo.list;
    else if(0 == _fetchStatus) {
      _fetchStatus = 1;

      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child('model_library_recent_comic_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryRecentComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        _fetchStatus = 2;

        PacketS2CLibraryRecentComicInfo packet = new PacketS2CLibraryRecentComicInfo();
        packet.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;

        return ModelLibraryRecentComicInfo.list;
      });
    }



    return null;
  }

  Future<List<ModelLibraryRecentComicInfo>> _fetchBytes(onFetchDone) async
  {
    print('PacketC2SLibraryRecentComicInfo : fetchBytes started');

    if(null != ModelLibraryRecentComicInfo.list)
      return ModelLibraryRecentComicInfo.list;

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

        PacketS2CLibraryRecentComicInfo packet = new PacketS2CLibraryRecentComicInfo();
        packet.parseBytes(packetSize,byteData,onFetchDone);
      }

      return ModelLibraryRecentComicInfo.list;
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

    return ModelLibraryRecentComicInfo.list;
  }


}