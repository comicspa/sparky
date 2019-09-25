
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_comic_detail_info.dart';
import 'package:sparky/models/model_comic_detail_info.dart';



class PacketC2SComicDetailInfo extends PacketC2SCommon
{
  String _userId;
  String _comicId;
  int _fetchStatus = 0;

  PacketC2SComicDetailInfo()
  {
    type = e_packet_type.c2s_comic_detail_info;
  }

  void generate(String userId,String comicId)
  {
    _userId = userId;
    _comicId = comicId;
  }

  /*
  Future<void> fetchJson(onFetchDone) async
  {
    print('PacketC2SPreset : fetch started');

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_preset');
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('[PacketC2SPreset:fetch] - ${snapshot.value}');

      PacketS2CPreset preset = new PacketS2CPreset();
      preset.parseJson(snapshot.value , onFetchDone);

    });
  }
  */



  Future<ModelComicDetailInfo> fetchBytes(onFetchDone) async
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


    List<int> userIdList = readyWriteStringToByteBuffer(_userId);
    List<int> comicIdList = readyWriteStringToByteBuffer(_comicId);

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