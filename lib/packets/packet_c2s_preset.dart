
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_preset.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SPreset extends PacketC2SCommon
{

  PacketC2SPreset()
  {
    type = e_packet_type.c2s_preset;
  }

  Future<void> fetch(onFetchDone) async
  {
    print('PacketC2SPreset : fetch started');

    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_preset');
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('[PacketC2SPreset:fetch] - ${snapshot.value}');

      PacketS2CPreset preset = new PacketS2CPreset();
      preset.parseFireBaseDBJson(snapshot.value , onFetchDone);

    });
  }





}