
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_s2c_preset_library_info.dart';
import 'package:sparky/packets/packet_c2s_library_continue_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_owned_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_recent_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_view_list_comic_info.dart';
import 'package:sparky/manage/manage_message.dart';



class PacketC2SPresetLibraryInfo extends PacketC2SCommon
{
  int _count = 0;

  PacketC2SLibraryContinueComicInfo _packetC2SLibraryContinueComicInfo = new PacketC2SLibraryContinueComicInfo();
  PacketC2SLibraryOwnedComicInfo _packetC2SLibraryOwnedComicInfo = new PacketC2SLibraryOwnedComicInfo();
  PacketC2SLibraryRecentComicInfo _packetC2SLibraryRecentComicInfo = new  PacketC2SLibraryRecentComicInfo();
  PacketC2SLibraryViewListComicInfo _packetC2SLibraryViewListComicInfo = new PacketC2SLibraryViewListComicInfo();

  PacketC2SPresetLibraryInfo()
  {
    type = e_packet_type.c2s_preset_library_info;
  }

  void generate()
  {
    _packetC2SLibraryContinueComicInfo.generate();
    _packetC2SLibraryOwnedComicInfo.generate();
    _packetC2SLibraryRecentComicInfo.generate();
    _packetC2SLibraryViewListComicInfo.generate();
  }

  void _onFetchDone(PacketS2CCommon s2cPacket)
  {
    print('[PacketC2SPresetLibraryInfo] : onFetchDone - $_count');

    switch(_count)
    {
      case 0:
        {
          _count = 1;
          _packetC2SLibraryOwnedComicInfo.fetch(_onFetchDone);
        }
        break;

      case 1:
        {
          _count = 2;
          _packetC2SLibraryRecentComicInfo.fetch(_onFetchDone);
        }
        break;

      case 2:
        {
          _count = 3;
          _packetC2SLibraryViewListComicInfo.fetch(_onFetchDone);
        }
        break;

      case 3:
        {
          ManageMessage.streamController.add(e_packet_type.s2c_preset_library_info);
        }
        break;

      default:
        break;

    }
  }


  Future<void> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }


  Future<void> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SPresetLibraryInfo : fetchFireBaseDB started');
    _packetC2SLibraryContinueComicInfo.fetch(_onFetchDone);
    return null;
  }


  Future<void> _fetchBytes(onFetchDone) async
  {
    print('PacketC2SPresetComicInfo : fetchBytes started');

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

          PacketS2CPresetLibraryInfo packet = new PacketS2CPresetLibraryInfo();
          packet.parseBytes(packetSize,byteData,onFetchDone);
        }
      });


      int packetBodySize  = 0;
      if(0 == generateHeader(packetBodySize))
      {
        socket.add(packet);
      }

      // wait 5 seconds
      await Future.delayed(Duration(seconds: 5));
      socket.close();
    } catch(exception, stackTrace) {
      print(exception);
    }


  }


}