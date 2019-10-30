
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_subscribe_comic.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SSubscribeComic extends PacketC2SCommon
{
  String _creatorId;
  String _comicId;
  String _partId;
  String _seasonId;
  int _subscribed;
  String _userId;

  PacketC2SSubscribeComic()
  {
    type = e_packet_type.c2s_subscribe_comic;
  }


  void generate(String userId,String creatorId,String comicId,String partId,String seasonId,int subscribed)
  {
    _creatorId = creatorId;
    _userId = userId;
    _comicId = comicId;
    _partId = partId;
    _seasonId = seasonId;
    _subscribed = subscribed;

    respondPacket = null;
    respondPacket = new PacketS2CSubscribeComic();

  }



  Future<bool> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<bool> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SSubscribeComic : fetchFireBaseDB started');

    switch(respondPacket.status)
    {
      case e_packet_status.finish_dispatch_respond:
        return true;

      case e_packet_status.none:
        {
          respondPacket.status = e_packet_status.start_dispatch_request;
          break;
        }

      case e_packet_status.start_dispatch_request:
        return false;

      default:
        return false;
    }

    if(e_packet_status.start_dispatch_request == respondPacket.status)
    {
      String userId = ModelUserInfo.getInstance().uId;


      DatabaseReference modelReference = ManageFirebaseDatabase.reference.child('model_comic_detail_info').child('${_creatorId}_${_comicId}').child('subscribers');

      if(1 == _subscribed)
      {
        modelReference.update({
          userId: 1
        }).then((_) {
          (respondPacket as PacketS2CSubscribeComic).parseFireBaseDBJson(1, onFetchDone);
        });
      }
      else
      {
        modelReference.child(_userId).remove().then((_)
        {
          (respondPacket as PacketS2CSubscribeComic).parseFireBaseDBJson(0, onFetchDone);
        });
      }

    }


    return false;
  }


}