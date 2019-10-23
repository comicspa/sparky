import 'package:sparky/models/model_price_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_price_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_device_info.dart';


class PacketC2SPriceInfo  extends PacketC2SCommon
{

  PacketC2SPriceInfo()
  {
    type = e_packet_type.c2s_price_info;
  }

  void generate()
  {
    respondPacket = null;
    respondPacket = new PacketS2CPriceInfo();
  }

  Future<Map<dynamic,dynamic>> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<Map<dynamic,dynamic>> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SPriceInfo : fetchFireBaseDB started');

    if(e_packet_status.finish_dispatch_respond == respondPacket.status)
      return ModelPriceInfo.map;
    else if(e_packet_status.none == respondPacket.status)
    {
      respondPacket.status = e_packet_status.start_dispatch_request;

      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child('model_price_info').child(ManageDeviceInfo.getLanguageLocaleCode());
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SPriceInfo:fetchFireBaseDB ] - ${snapshot
            .value}');

        respondPacket.status = e_packet_status.finish_dispatch_request;
        (respondPacket as PacketS2CPriceInfo).parseFireBaseDBJson(snapshot.value, onFetchDone);
        return ModelPriceInfo.map;
      });
    }

    return null;
  }


}


