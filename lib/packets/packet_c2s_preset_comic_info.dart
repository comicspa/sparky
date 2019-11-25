
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_s2c_preset_comic_info.dart';
import 'package:sparky/packets/packet_c2s_featured_comic_info.dart';
import 'package:sparky/packets/packet_c2s_recommended_comic_info.dart';
import 'package:sparky/packets/packet_c2s_real_time_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_new_comic_info.dart';
import 'package:sparky/packets/packet_c2s_today_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_weekly_trend_comic_info.dart';
import 'package:sparky/manage/manage_message.dart';



class PacketC2SPresetComicInfo extends PacketC2SCommon
{
  int _count=0;
  PacketC2SFeaturedComicInfo _packetC2SFeaturedComicInfo = new PacketC2SFeaturedComicInfo();
  PacketC2SRecommendedComicInfo _packetC2SRecommendedComicInfo = new PacketC2SRecommendedComicInfo();
  PacketC2SRealTimeTrendComicInfo _packetC2sRealTimeTrendComicInfo = new PacketC2SRealTimeTrendComicInfo();
  PacketC2SNewComicInfo _packetC2SNewComicInfo = new PacketC2SNewComicInfo();
  PacketC2STodayTrendComicInfo _packetC2STodayTrendComicInfo = new PacketC2STodayTrendComicInfo();
  PacketC2SWeeklyTrendComicInfo _packetC2SWeeklyTrendComicInfo = new PacketC2SWeeklyTrendComicInfo();

  PacketC2SPresetComicInfo()
  {
    type = e_packet_type.c2s_preset_comic_info;
  }

  void generate()
  {
    _count = 0;

    _packetC2SFeaturedComicInfo.generate();
    _packetC2SRecommendedComicInfo.generate();
    _packetC2sRealTimeTrendComicInfo.generate();
    _packetC2SNewComicInfo.generate();
    _packetC2STodayTrendComicInfo.generate();
    _packetC2SWeeklyTrendComicInfo.generate();
  }

  void _onFetchDone(PacketS2CCommon packetS2CCommon)
  {
    if(e_packet_status.finish_dispatch_respond != packetS2CCommon.status)
      return;

    print('[PacketC2SPresetLibraryInfo] : onFetchDone - $_count');

    switch(_count)
    {
      case 0:
        {
          _count = 1;
          _packetC2SRecommendedComicInfo.fetch(_onFetchDone);
        }
        break;

      case 1:
        {
          _count = 2;
          _packetC2sRealTimeTrendComicInfo.fetch(_onFetchDone);
        }
        break;

      case 2:
        {
          _count = 3;
          _packetC2SNewComicInfo.fetch(_onFetchDone);
        }
        break;

      case 3:
        {
          _count = 4;
          _packetC2STodayTrendComicInfo.fetch(_onFetchDone);
        }
        break;

      case 4:
        {
          _count = 5;
          _packetC2SWeeklyTrendComicInfo.fetch(_onFetchDone);
        }
        break;

      case 5:
        {
          ManageMessage.streamController.add(packetS2CCommon);
          print('<------------------------------------------------- 1 -------------------------------------------------------');
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
    print('------------------------------------------------- 1 ------------------------------------------------------->');
    print('PacketC2SPresetComicInfo : fetchFireBaseDB started');
    _packetC2SFeaturedComicInfo.fetch(_onFetchDone);
    return null;
  }

  Future<void> _fetchBytes(onFetchDone) async
  {
    print('PacketC2SPresetLibraryInfo : fetchBytes started');

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

        PacketS2CPresetComicInfo packet = new PacketS2CPresetComicInfo();
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