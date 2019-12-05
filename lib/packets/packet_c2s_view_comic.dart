
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_view_comic.dart';
import 'package:sparky/models/model_view_comic.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';



class PacketC2SViewComic extends PacketC2SCommon
{
  String _userId;
  String _comicId;
  String _episodeId;
  String _partId = '001';
  String _seasonId = '001';


  PacketC2SViewComic()
  {
    type = e_packet_type.c2s_view_comic;
  }

  void generate(String userId,String comicId,String episodeId)
  {
    reset();

    //ModelViewComic.list = null;

    _userId = userId;
    _comicId = comicId;
    _episodeId = episodeId;

    respondPacket = null;
    respondPacket = new PacketS2CViewComic();


    print('episodeId : $_episodeId');
  }

  Future<ModelViewComic> fetch(onFetchDone) async
  {
    return await _fetchFireBaseDB(onFetchDone);
  }


  Future<ModelViewComic> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SViewComic : fetchFireBaseDB started');

    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelViewComic.getInstance();

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
      String id = '${_userId}_${_comicId}_${_episodeId}';
      print('id : $id');
      DatabaseReference modelComicDetailInfoReference = ManageFirebaseDatabase
          .reference.child('model_view_comic_info').child(id);
      modelComicDetailInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SViewComic : fetchFireBaseDB ] - ${snapshot.value}');

        (respondPacket as PacketS2CViewComic).parseFireBaseDBJson(
            _userId,
            _comicId,
            _partId,
            _seasonId,
            _episodeId,
            snapshot.value,
            onFetchDone);
      });
    }

    return null;
  }



  /*
  Future<List<ModelViewComic>> fetch(onFetchDone) async
  {
    return await _fetchFireBaseDB(onFetchDone);
  }

  Future<List<ModelViewComic>> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SViewComic : fetchFireBaseDB started');

    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return ModelViewComic.list;

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
      String id = '${_userId}_${_comicId}_${_episodeId}';
      print('id : $id');
      DatabaseReference modelComicDetailInfoReference = ManageFirebaseDatabase
          .reference.child('model_view_comic_info').child(id);
      modelComicDetailInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SViewComic : fetchFireBaseDB ] - ${snapshot.value}');

        (respondPacket as PacketS2CViewComic).parseFireBaseDBJson(
            _userId,
            _comicId,
            _partId,
            _seasonId,
            _episodeId,
            snapshot.value,
            onFetchDone);


      });
    }

    return null;
  }


  Future<List<ModelViewComic>> _fetchBytes(onFetchDone) async
  {
    print('PacketC2SViewComic : fetchBytes started');
    //if(null != ModelViewComic.list)
    //  return ModelViewComic.list;
    if(e_packet_status.finish_dispatch_respond == respondPacket.status)
      return  ModelViewComic.list;

    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    final List<int> eventList = new List<int>();
    socket.listen((List<int> event)
    {
      eventList.addAll(event);
      var packet = Uint8List.fromList(eventList);
      ByteData byteData = ByteData.view(packet.buffer);

      int packetSize = byteData.getUint32(0,PacketCommon.endian);
      if(eventList.length == packetSize)
      {
        (respondPacket as PacketS2CViewComic).parseBytes(packetSize,byteData,onFetchDone);

        //return ModelViewComic.getInstance();
        //return ModelViewComic.list;
      }
      return null;
    });

    List<int> userIdList = readyWriteStringToByteBuffer(_userId);
    List<int> comicIdList = readyWriteStringToByteBuffer(_comicId);
    List<int> episodeIdList = readyWriteStringToByteBuffer(_episodeId);
    List<int> partIdList = readyWriteStringToByteBuffer(_partId);
    List<int> seasonIdList = readyWriteStringToByteBuffer(_seasonId);

    int packetBodySize  = getStringTotalLength(userIdList) + getStringTotalLength(comicIdList)+
        getStringTotalLength(episodeIdList) + getStringTotalLength(partIdList) + getStringTotalLength(seasonIdList);
    generateHeader(packetBodySize);

    writeStringToByteBuffer(userIdList);
    writeStringToByteBuffer(comicIdList);
    writeStringToByteBuffer(episodeIdList);
    writeStringToByteBuffer(partIdList);
    writeStringToByteBuffer(seasonIdList);

    respondPacket.status = e_packet_status.finish_dispatch_request;
    socket.add(packet);
    respondPacket.status = e_packet_status.wait_respond;

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

    return null;
  }
  */

}