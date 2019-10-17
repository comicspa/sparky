
import 'dart:io';
import 'dart:typed_data';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_unregister_translator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SUnregisterTranslator extends PacketC2SCommon
{
  String _nickName = 'onlyme';
  String _uId;

  PacketC2SUnregisterTranslator()
  {
    type = e_packet_type.c2s_unregister_translator;
  }

  void generate(String uId)
  {
    _uId = uId;
  }


  Future<void> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<void> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SUnregisterCreator : fetchFireBaseDB started');

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_user_info');
    modelUserInfoReference.child(_uId).child('translators').child('0').remove().then((_) {

      PacketS2CUnregisterTranslator packet = new PacketS2CUnregisterTranslator();
      packet.parseFireBaseDBJson(onFetchDone);

    });

  }


  void fetchBytes(onPacketUnregisterCreatorFetchDone) async
  {
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CUnregisterTranslator packet = new PacketS2CUnregisterTranslator();
      packet.parseBytes(event);
      onPacketUnregisterCreatorFetchDone(packet);
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
