
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_user_info.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';




class PacketC2SUserInfo extends PacketC2SCommon
{
  String _userId;
  String _accessToken = 'accessToken';
  int _fetchStatus = 0;

  PacketC2SUserInfo()
  {
    type = e_packet_type.c2s_user_info;
  }

  void generate(String userId)
  {
    //_accessToken = accessToken;
    _userId = userId;
  }



  Future<ModelUserInfo> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<ModelUserInfo> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SUserInfo : fetchFireBaseDB started');

    //if(2 == _fetchStatus)
    //  return ModelUserInfo.getInstance();

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_user_info').child(_userId);
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('[PacketC2SUserInfo : fetchFireBaseDB ] - ${snapshot.value}');

      PacketS2CUserInfo packet = new PacketS2CUserInfo();
      packet.parseFireBaseDBJson(snapshot.value , onFetchDone);

      return ModelUserInfo.getInstance();

    });

    return ModelUserInfo.getInstance();
  }



  Future<ModelUserInfo> _fetchBytes(onFetchDone) async
  {
    print('PacketC2SUserInfo : fetchBytes started');
    if(2 == _fetchStatus)
      return ModelUserInfo.getInstance();

    try {
      Socket socket = await ModelCommon.createServiceSocket();
      print('connected server');

      // listen to the received data event stream
      final List<int> eventList = new List<int>();
      socket.listen((List<int> event) {
        eventList.addAll(event);
        var packet = Uint8List.fromList(eventList);
        ByteData byteData = ByteData.view(packet.buffer);

        int packetSize = byteData.getUint32(0, PacketCommon.endian);
        if (eventList.length == packetSize) {
          PacketS2CUserInfo packet = new PacketS2CUserInfo();
          packet.parseBytes(packetSize, byteData,onFetchDone);

          //print(ModelUserInfo.getInstance().toString());
          //print('2');
          _fetchStatus = 2;
          return ModelUserInfo.getInstance();
        }

        return null;
      });


      List<int> accessTokenList = readyWriteStringToByteBuffer(_accessToken);
      int packetBodySize = getStringTotalLength(accessTokenList);
      generateHeader(packetBodySize);

      writeStringToByteBuffer(accessTokenList);
      socket.add(packet);

      // wait 5 seconds
      await Future.delayed(Duration(seconds: 5));
      socket.close();
    }
    catch(e)
    {
      print(e);
    }

    _fetchStatus = 1;
    return null;
  }


}