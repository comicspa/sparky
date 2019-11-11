
import 'dart:io';
import 'dart:typed_data';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_register_translator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparky/manage/manage_firebase_cloud_firestore.dart';


class PacketC2SRegisterTranslator extends PacketC2SCommon
{
  //String _nickName = 'onlyme';
  String _uId;
  int _databaseType = 1;

  PacketC2SRegisterTranslator()
  {
    type = e_packet_type.c2s_register_translator;
  }

  void generate(String uId)
  {
    _uId = uId;
  }

  Future<void> fetch(onFetchDone) async
  {
    Future<void> fetch(onFetchDone) async
    {
      switch(_databaseType)
      {
        case 0:
          {
            _fetchRealtimeDB(onFetchDone);
          }
          break;

        case 1:
          {
            _fetchFirestoreDB(onFetchDone);
          }
          break;

        default:
          break;
      }
    }
  }

  Future<void> _fetchFirestoreDB(onFetchDone) async
  {
    print('PacketC2SRegisterTranslator : _fetchFirestoreDB started');

    String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    String translatorId = '${_uId}translator$currentTime';
    await ManageFireBaseCloudFireStore.reference.collection(ModelUserInfo.ModelName)
        .document(_uId).collection('translators').document(translatorId)
        .updateData({
      'create_time':currentTime,
    }).then((_) {

      PacketS2CRegisterTranslator packet = new PacketS2CRegisterTranslator();
      packet.parseFireBaseDBJson(onFetchDone,translatorId);

      //});
    });
  }


  Future<void> _fetchRealtimeDB(onFetchDone) async
  {
    print('PacketC2SRegisterTranslator : _fetchRealtimeDB started');

    //List<int> uIdBytes = utf8.encode(_uId);
    //Base64Codec base64Codec = new Base64Codec();
    //String uIdBase64 = base64Codec.encode(uIdBytes);

    String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    String translatorId = '${_uId}translator$currentTime';
    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child(ModelUserInfo.ModelName);
    modelUserInfoReference.child(_uId).child('translators').child(translatorId).update({
      'create_time':currentTime,
    }).then((_) {

      PacketS2CRegisterTranslator packet = new PacketS2CRegisterTranslator();
      packet.parseFireBaseDBJson(onFetchDone,translatorId);

    });
  }


  void fetchBytes(onPacketRegisterCreatorFetchDone) async
  {
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CRegisterTranslator packet = new PacketS2CRegisterTranslator();
      packet.parseBytes(event);
      onPacketRegisterCreatorFetchDone(packet);
    });


    List<int> socialIdList = PacketUtility.readyWriteStringToByteBuffer(_uId);

    int packetBodySize  = PacketUtility.getStringTotalLength(socialIdList);
    generateHeader(packetBodySize);

    writeStringToByteBuffer(socialIdList);

    socket.add(packet);

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

  }

}
