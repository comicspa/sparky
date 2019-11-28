
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_comic_detail_info.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SComicDetailInfo extends PacketC2SCommon
{
  String _creatorId;
  String _comicNumber;
  String _partNumber;
  String _seasonNumber;
  int _fetchStatus = 0;
  PacketS2CComicDetailInfo _packetS2CComicDetailInfo;

  PacketC2SComicDetailInfo()
  {
    type = e_packet_type.c2s_comic_detail_info;
  }

  void generate(String creatorId,String comicNumber,String partNumber,String seasonNumber)
  {
    _fetchStatus = 0;
    _creatorId = creatorId;
    _comicNumber = comicNumber;
    _partNumber = partNumber;
    _seasonNumber = seasonNumber;

    _creatorId = '1566811403000';

    if(null != _packetS2CComicDetailInfo)
      _packetS2CComicDetailInfo.clear();
    else
      _packetS2CComicDetailInfo = new PacketS2CComicDetailInfo();

  }

  Future<ModelComicDetailInfo> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<ModelComicDetailInfo> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SComicDetailInfo : fetchFireBaseDB started');

    if(3 == _fetchStatus)
      return ModelComicDetailInfo.getInstance();
    else if(0 == _fetchStatus)
    {
      _fetchStatus = 1;

      String id = '${_creatorId}_${_comicNumber}';
      print('id : $id');
      DatabaseReference modelComicDetailInfoReference = ManageFirebaseDatabase
          .reference.child('model_comic_detail_info').child(id);
      modelComicDetailInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SComicDetailInfo : fetchFireBaseDB ] - ${snapshot
            .value}');

        _fetchStatus = 2;

        if(null != _packetS2CComicDetailInfo)
          _packetS2CComicDetailInfo.parseFireBaseDBJson(snapshot.value, onFetchDone);

        _fetchStatus = 3;
       
        return ModelComicDetailInfo.getInstance();
      });
    }

    return null;
  }



  Future<ModelComicDetailInfo> _fetchBytes(onFetchDone) async
  {
    print('PacketC2SComicDetailInfo : fetchBytes started');
    if(0 != _fetchStatus)
      return ModelComicDetailInfo.getInstance();

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

        PacketS2CComicDetailInfo packet = new PacketS2CComicDetailInfo();
        packet.parseBytes(packetSize,byteData,onFetchDone);

        _fetchStatus = 2;
      }

      return ModelComicDetailInfo.getInstance();
    });


    List<int> userIdList = readyWriteStringToByteBuffer(_creatorId);
    List<int> comicIdList = readyWriteStringToByteBuffer(_comicNumber);

    int packetBodySize  = getStringTotalLength(userIdList) + getStringTotalLength(comicIdList);

    if(0 == generateHeader(packetBodySize)) {
      writeStringToByteBuffer(userIdList);
      writeStringToByteBuffer(comicIdList);

      socket.add(packet);
    }

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

    _fetchStatus = 1;
    return ModelComicDetailInfo.getInstance();
  }


}