
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_view_comic.dart';
import 'package:sparky/models/model_view_comic.dart';



class PacketC2SViewComic extends PacketC2SCommon
{
  String _userId;
  String _comicId;
  String _episodeId;
  String _partId = '001';
  String _seasonId = '001';
  int _fetchStatus = 0;

  PacketC2SViewComic()
  {
    type = e_packet_type.c2s_view_comic;
  }

  void generate(String userId,String comicId,String episodeId)
  {
    reset();
    _fetchStatus = 0;
    _userId = userId;
    _comicId = comicId;
    _episodeId = episodeId;

    print('episodeId : $_episodeId');
  }


  Future<List<ModelViewComic>> fetchBytes(onFetchDone) async
  {
    print('PacketC2SViewComic : fetchBytes started');
    //if(null != ModelViewComic.list)
    //  return ModelViewComic.list;
    if(0 != _fetchStatus)
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
        PacketS2CViewComic packet = new PacketS2CViewComic();
        packet.parseBytes(packetSize,byteData,onFetchDone);

        _fetchStatus = 2;
        //return ModelViewComic.getInstance();
        return ModelViewComic.list;
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


    socket.add(packet);

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

    _fetchStatus = 1;
    return ModelViewComic.list;
  }


}