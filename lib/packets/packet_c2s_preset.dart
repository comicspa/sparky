
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_s2c_preset.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SPreset extends PacketC2SCommon
{
  OnFetchDone _onFetchDone;
  int _databaseType = 1;

  PacketC2SPreset()
  {
    type = e_packet_type.c2s_preset;
  }

  void generate({OnFetchDone onFetchDone})
  {
    _onFetchDone = onFetchDone;

    respondPacket = null;
    respondPacket = new PacketS2CPreset();
  }

  Future<String> fetch(onFetchDone) async
  {
    print('PacketC2SPreset : fetch started');

    switch (_databaseType)
    {
      case 0:
        {
           return _fetchRealtimeDB(onFetchDone);
        }
        break;

      case 1:
        {
          return _fetchFirestoreDB(onFetchDone);
        }
        break;

      default:
        break;
    }

    return null;
  }

  Future<String> _fetchFirestoreDB(onFetchDone) async
  {
    print('PacketC2SPreset : _fetchFirestoreDB started');

    if(null != ModelPreset.faqUrl)
      return ModelPreset.faqUrl;

    Firestore.instance
        .collection(ModelPreset.ModelName)
        .getDocuments()
        .then((QuerySnapshot snapshot)
    {
      snapshot.documents..forEach((f) => print('${f.data}}'));

      PacketS2CPreset preset = new PacketS2CPreset();
      preset.parseCloudFirestoreJson(snapshot.documents, _onFetchDone);
      return ModelPreset.faqUrl;

    });

    return null;
  }

  Future<String> _fetchRealtimeDB(onFetchDone) async
  {
    print('PacketC2SPreset : _fetchRealtimeDB started');

    if(null != ModelPreset.faqUrl)
      return ModelPreset.faqUrl;

    /*
    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return;

      case e_packet_status.none:
        {
          respondPacket.status = e_packet_status.start_dispatch_request;
          break;
        }

      case e_packet_status.start_dispatch_request:
        return;

      default:
        return;
    }

    if(e_packet_status.start_dispatch_request == respondPacket.status)
    {
      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child('model_preset');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SPreset:fetchFireBaseDB ] - ${snapshot
            .value}');

        (respondPacket as PacketS2CPreset).parseFireBaseDBJson(snapshot.value, onFetchDone);
      });
    }
  */

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
        .reference.child(ModelPreset.ModelName);
    modelUserInfoReference.once().then((DataSnapshot snapshot) {
      print('[PacketC2SPreset:fetch] - ${snapshot.value}');

      PacketS2CPreset preset = new PacketS2CPreset();
      preset.parseRealtimeDatabaseJson(snapshot.value, onFetchDone);
      return ModelPreset.faqUrl;
    });

    return null;
  }
}