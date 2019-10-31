
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_preset.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SPreset extends PacketC2SCommon
{
  int _databaseSwitch = 1;

  PacketC2SPreset()
  {
    type = e_packet_type.c2s_preset;
  }

  void generate()
  {
    respondPacket = null;
    respondPacket = new PacketS2CPreset();
  }

  Future<void> fetch(onFetchDone) async
  {
    print('PacketC2SPreset : fetch started');

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


    switch (_databaseSwitch) {
      case 0:
        {
          DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
              .reference.child('model_preset');
          modelUserInfoReference.once().then((DataSnapshot snapshot) {
            print('[PacketC2SPreset:fetch] - ${snapshot.value}');

            PacketS2CPreset preset = new PacketS2CPreset();
            preset.parseRealtimeDatabaseJson(snapshot.value, onFetchDone);
          });
        }
        break;

    case 1:
    {
      Firestore.instance
          .collection("model_preset")
          .getDocuments()
          .then((QuerySnapshot snapshot)
      {
        snapshot.documents..forEach((f) => print('${f.data}}'));

        PacketS2CPreset preset = new PacketS2CPreset();
        preset.parseCloudFirestoreJson(snapshot.documents, onFetchDone);

      });


    }
    break;

      default:
        break;
  }

  }











}