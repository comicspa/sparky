import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_library_owned_comic_info.dart';
import 'package:sparky/models/model_library_owned_comic_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PacketC2SLibraryOwnedComicInfo extends PacketC2SCommon
{
  int _pageCountIndex = 0;
  int _pageViewCount = 0;
  int _fetchStatus = 0;
  bool _wantLoad = false;
  int _databaseType = 1;

  PacketC2SLibraryOwnedComicInfo()
  {
    type = e_packet_type.c2s_library_owned_comic_info;
  }

  void generate(OnFetchDone onFetchDone,{bool recreateList = false})
  {
    _fetchStatus = 0;
    this.onFetchDone = onFetchDone;
    ModelLibraryOwnedComicInfo.status = e_packet_status.start_dispatch_request;
    if(null == respondPacket)
      respondPacket = new PacketS2CLibraryOwnedComicInfo();
    else
      respondPacket.reset();

    if(true == recreateList)
    {
      if(null != ModelLibraryOwnedComicInfo.list)
      {
        ModelLibraryOwnedComicInfo.list.clear();
        ModelLibraryOwnedComicInfo.list = null;
      }
    }

    _wantLoad = true;
  }


  Future<List<ModelLibraryOwnedComicInfo>> fetch(onFetchDone) async
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



  Future<List<ModelLibraryOwnedComicInfo>> _fetchFireStoreDB(onFetchDone) async
  {
    print('PacketC2SLibraryOwnedComicInfo : _fetchFireStoreDB started');

    if(e_packet_status.none == ModelLibraryOwnedComicInfo.status || e_packet_status.finish_dispatch_respond == ModelLibraryOwnedComicInfo.status)
      return ModelLibraryOwnedComicInfo.list;
    if(null == respondPacket)
      return null;

    print('aaaa : ${respondPacket.status.toString()}');
    if(e_packet_status.none == respondPacket.status)
    {
      print('bbbb');
      respondPacket.status = e_packet_status.start_dispatch_request;
      ModelLibraryOwnedComicInfo.status = e_packet_status.start_dispatch_request;

      List<ModelLibraryOwnedComicInfo> list;
      await ManageFireBaseCloudFireStore.getQuerySnapshot(ModelLibraryOwnedComicInfo.ModelName).then((QuerySnapshot snapshot)
      {
        respondPacket.status = e_packet_status.wait_respond;
        ModelLibraryOwnedComicInfo.status = e_packet_status.wait_respond;

        for (int countIndex = 0; countIndex < snapshot.documents.length; ++countIndex)
        {
          var map = snapshot.documents[countIndex].data;

          ModelLibraryOwnedComicInfo modelLibraryOwnedComicInfo = new ModelLibraryOwnedComicInfo();
          modelLibraryOwnedComicInfo.comicNumber = map['comic_number'];;
          modelLibraryOwnedComicInfo.creatorId = map['creator_id'];
          modelLibraryOwnedComicInfo.partNumber = map['part_number'];
          modelLibraryOwnedComicInfo.seasonNumber = map['season_number'];

          //print('comicNumber : ${modelFeaturedComicInfo.comicNumber}');
          //print('creatorId : ${modelFeaturedComicInfo.creatorId}');
          //print('partNumber : ${modelFeaturedComicInfo.partNumber}');
          //print('seasonNumber : ${modelFeaturedComicInfo.seasonNumber}');

          if (null == list)
            list = new List<ModelLibraryOwnedComicInfo>();
          list.add(modelLibraryOwnedComicInfo);

        }
      });


      if(null != list)
      {
        for(int countIndex=0; countIndex<list.length; ++countIndex)
        {
          ModelLibraryOwnedComicInfo modelLibraryOwnedComicInfo = list[countIndex];

          print('comicId : ${modelLibraryOwnedComicInfo.comicId}');

          await ManageFireBaseCloudFireStore.getDocumentSnapshot(ModelComicInfo.ModelName,modelLibraryOwnedComicInfo.comicId).then((documentSnapshot)
          {
            print('document : ${documentSnapshot.data.toString()}');

            modelLibraryOwnedComicInfo.titleName = documentSnapshot.data['title_name'];
            modelLibraryOwnedComicInfo.creatorName = documentSnapshot.data['creator_name1'] + '/' + documentSnapshot.data['creator_name2'];

            if (list.length - 1 == countIndex)
            {
              print('[PacketC2SLibraryOwnedComicInfo : _fetchFireStoreDB] - list.length - 1 == countIndex');

              if (null == respondPacket)
                respondPacket = new PacketS2CLibraryOwnedComicInfo();
              respondPacket.status = e_packet_status.finish_dispatch_respond;
              ModelLibraryOwnedComicInfo.status = e_packet_status.finish_dispatch_respond;

              ModelLibraryOwnedComicInfo.list = list;

              if (null != this.onFetchDone)
                this.onFetchDone(respondPacket);

            }
          });
        }
      }
    }

    return null;
  }



  Future<List<ModelLibraryOwnedComicInfo>> _fetchRealTimeDB(onFetchDone) async
  {
    print('PacketC2SLibraryOwnedComicInfo : fetchFireBaseDB started');
    if(false == _wantLoad)
      return ModelLibraryOwnedComicInfo.list;

    /*
    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelLibraryOwnedComicInfo.list;

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
          .reference.child('model_library_owned_comic_info');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryContinueComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        (respondPacket as PacketS2CLibraryOwnedComicInfo).parseFireBaseDBJson(snapshot.value, onFetchDone);

        return ModelLibraryOwnedComicInfo.list;
      });
    }
     */


    if(3 == _fetchStatus)
      return ModelLibraryOwnedComicInfo.list;
    else if(0 == _fetchStatus) {
      _fetchStatus = 1;

      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child(ModelLibraryOwnedComicInfo.ModelName);
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLibraryOwnedComicInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        _fetchStatus = 2;

        PacketS2CLibraryOwnedComicInfo packet = new PacketS2CLibraryOwnedComicInfo();
        packet.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;

        return ModelLibraryOwnedComicInfo.list;
      });
    }

    return null;
  }


  Future<List<ModelLibraryOwnedComicInfo>> _fetchBytes(onFetchDone) async
  {
    print('PacketC2SLibraryOwnedComicInfo : fetchBytes started');

    if(null != ModelLibraryOwnedComicInfo.list)
      return ModelLibraryOwnedComicInfo.list;

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

        PacketS2CLibraryOwnedComicInfo packet = new PacketS2CLibraryOwnedComicInfo();
        packet.parseBytes(packetSize,byteData,onFetchDone);
      }

      return ModelLibraryOwnedComicInfo.list;
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

    return ModelLibraryOwnedComicInfo.list;
  }


}