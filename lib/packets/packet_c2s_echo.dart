
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_echo.dart';

class PacketC2SEcho extends PacketC2SCommon
{
  Socket _socket;
  int _fetchStatus = 0;
  final List<int> _eventList = new List<int>();

  PacketC2SEcho()
  {
    type = e_packet_type.c2s_echo;
  }

  void generate()
  {
    _eventList.clear();
    _fetchStatus = 0;
    if(null != respondPacket)
      (respondPacket as PacketS2CEcho).clear();
    else
      respondPacket = new PacketS2CEcho();

  }

  Future<String> fetch(onFetchDone) async
  {
    return _fetchBytes(onFetchDone);
  }


  Future<String> _fetchBytes(onFetchDone) async
  {
    print('PacketC2SEcho : fetchBytes started');
    if(0 != _fetchStatus)
      return (respondPacket as PacketS2CEcho).message;

    if(null == _socket)
      _socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    _socket.listen((List<int> event)
    {
      print('socket.listen : ${event.length}');
      _eventList.addAll(event);
      print('socket.listen : ${_eventList.length}');

      var packet = Uint8List.fromList(_eventList);
      ByteData byteData = ByteData.view(packet.buffer);
      //print('eventList.length : ${eventList.length}');

      int packetSize = byteData.getUint32(0,PacketCommon.endian);
      //print('byteData.getUint32(0) : $packetSize');

      if(_eventList.length == packetSize)
      {
        //print('eventList.length == packetSize');
        _eventList.clear();
        (respondPacket as PacketS2CEcho).parseBytes(packetSize,byteData,onFetchDone);
        _fetchStatus = 2;

      }

      return (respondPacket as PacketS2CEcho).message;
    });


    int packetBodySize  = 4;
    if(0 == generateHeader(packetBodySize))
    {
      setUint32(0);
      _socket.add(packet);
    }

    // wait 5 seconds
    //await Future.delayed(Duration(seconds: 5));
    //socket.close();

    _fetchStatus = 1;
    return (respondPacket as PacketS2CEcho).message;;
  }


  void send()
  {
    _eventList.clear();
    int packetBodySize  = 0;
    if(0 == resetHeader(packetBodySize))
    {
      _socket.add(packet);
    }


  }


}