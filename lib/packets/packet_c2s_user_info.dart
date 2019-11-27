
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_s2c_user_info.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class PacketC2SUserInfo extends PacketC2SCommon
{
  String _userId;
  int _fetchStatus = 0;
  int _databaseType = 0;
  OnFetchDone _onFetchDone;

  PacketC2SUserInfo()
  {
    type = e_packet_type.c2s_user_info;
  }

  //
  void generate(String userId,OnFetchDone onFetchDone)
  {
    _userId = userId;
    _onFetchDone = onFetchDone;
  }

  //
  Future<ModelUserInfo> fetch(onFetchDone) async
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

  //
  Future<ModelUserInfo> _fetchFireStoreDB(onFetchDone) async
  {
    print('PacketC2SUserInfo : _fetchFireStoreDB started');

    if(true == ModelUserInfo.getInstance().signedIn)
      return ModelUserInfo.getInstance();

    Firestore.instance.collection(ModelUserInfo.ModelName).document(_userId).get().then((documentSnapshot)
    {
      CollectionReference creatorsCollectionReference = documentSnapshot.reference.collection('creators');
      if(null != creatorsCollectionReference)
      {
        creatorsCollectionReference.getDocuments().then((QuerySnapshot snapshot)
        {
          for(int documentCountIndex=0; documentCountIndex<snapshot.documents.length; ++documentCountIndex)
            {
              print(snapshot.documents[documentCountIndex].documentID);
              ModelUserInfo.getInstance().searchAddCreatorId(snapshot.documents[documentCountIndex].documentID);
            }
          //snapshot.documents.forEach((f) => print('${f.data}}'));
        });
      }
      else
      {
        print('null == creatorsCollectionReference');
      }

      CollectionReference translatorsCollectionReference = documentSnapshot.reference.collection('translators');
      if(null != translatorsCollectionReference)
      {
        translatorsCollectionReference.getDocuments().then((QuerySnapshot snapshot)
        {
          for(int documentCountIndex=0; documentCountIndex<snapshot.documents.length; ++documentCountIndex)
          {
            print(snapshot.documents[documentCountIndex].documentID);
            ModelUserInfo.getInstance().searchAddTranslatorId(snapshot.documents[documentCountIndex].documentID);
          }
          //snapshot.documents.forEach((f) => print('${f.data}}'));
        });
      }
      else
      {
        print('null == translatorsCollectionReference');
      }

      /*
      //test
      CollectionReference test = documentSnapshot.reference.collection('test');
      if(null == test)
        {
          print('null == test');
        }
      else
        {
          print('null != test11111');

          test.getDocuments().then((QuerySnapshot snapshot)
          {
            snapshot.documents.forEach((f) => print('${f.data}}'));
          });

          print('null != test22222');
        }
      */

      print('document : ${documentSnapshot.data.toString()}');

      PacketS2CUserInfo packet = new PacketS2CUserInfo();
      packet.parseCloudFirestoreJson(documentSnapshot.data , _onFetchDone);

      return ModelUserInfo.getInstance();
    });


    return null;
  }


  //
  Future<ModelUserInfo> _fetchRealTimeDB(onFetchDone) async
  {
    print('PacketC2SUserInfo : _fetchRealTimeDB started');

    //if(2 == _fetchStatus)
    //  return ModelUserInfo.getInstance();

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child(ModelUserInfo.ModelName).child(_userId);
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('[PacketC2SUserInfo : _fetchRealTimeDB ] - ${snapshot.value}');

      PacketS2CUserInfo packet = new PacketS2CUserInfo();
      packet.parseRealtimeDBJson(snapshot.value , onFetchDone);

      return ModelUserInfo.getInstance();

    });

    return ModelUserInfo.getInstance();
  }


  //
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

      List<int> accessTokenList = readyWriteStringToByteBuffer(_userId);
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