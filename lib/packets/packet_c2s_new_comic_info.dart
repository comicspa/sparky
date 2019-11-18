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

  void generate(int pageViewCount,int pageCountIndex)
  {
    _pageViewCount = pageViewCount;
    _pageCountIndex = pageCountIndex;
    _fetchStatus = 0;
    respondPacket = null;
    respondPacket = new PacketS2CNewComicInfo();
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

    //if(3 == _fetchStatus)
    //  return ModelNewComicInfo.list;
    if(null != ModelNewComicInfo.list)
      return ModelNewComicInfo.list;


    if(0 == _fetchStatus)
    {
      _fetchStatus = 1;

      await ManageFireBaseCloudFireStore.getQuerySnapshot(ModelNewComicInfo.ModelName).then((QuerySnapshot snapshot)
      {
        _fetchStatus = 2;
        for (int countIndex = 0; countIndex < snapshot.documents.length; ++countIndex)
        {
          var map = snapshot.documents[countIndex].data;
          String comicNumber = map['comic_number'];
          String creatorId = map['creator_id'];
          String partNumber = map['part_number'];
          String seasonNumber = map['season_number'];

          ModelNewComicInfo modelNewComicInfo = new ModelNewComicInfo();
          modelNewComicInfo.comicNumber = comicNumber;
          modelNewComicInfo.creatorId = creatorId;
          modelNewComicInfo.partNumber = partNumber;
          modelNewComicInfo.seasonNumber = seasonNumber;

          if (null == ModelNewComicInfo.list)
            ModelNewComicInfo.list = new List<ModelNewComicInfo>();
          ModelNewComicInfo.list.add(modelNewComicInfo);

          String comicId = creatorId + '_' + comicNumber + '_' + partNumber + '_' + seasonNumber;
          ManageFireBaseCloudFireStore.getDocumentSnapshot(ModelComicInfo.ModelName, comicId).then((documentSnapshot)
          {
            print('document : ${documentSnapshot.data.toString()}');

            modelNewComicInfo.titleName = documentSnapshot.data['title_name'];
            modelNewComicInfo.creatorName = documentSnapshot.data['creator_name1'] + '/' + documentSnapshot.data['creator_name2'];

            if (snapshot.documents.length - 1 == countIndex)
            {
              print('snapshot.documents.length - 1 == countIndex');
              _fetchStatus = 3;

              if (null == respondPacket)
                respondPacket = new PacketS2CNewComicInfo();
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

    return ModelNewComicInfo.list;
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