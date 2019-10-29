
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_like_comic.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SLikeComic extends PacketC2SCommon
{
  String _comicId;
  String _partId;
  String _seasonId;
  bool _like;

  PacketC2SLikeComic()
  {
    type = e_packet_type.c2s_like_comic;
  }


  void generate(String comicId,String partId,String seasonId,bool like)
  {
    _comicId = comicId;
    _partId = partId;
    _seasonId = seasonId;
    _like = like;

    respondPacket = null;
    respondPacket = new PacketS2CLikeComic();

  }



  Future<bool> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<bool> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SLikeComic : fetchFireBaseDB started');

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
      String userId;
      if(null == ModelUserInfo.getInstance().uId)
      {
        userId = ManageDeviceInfo.deviceId;
      }
      else
      {
        userId = ModelUserInfo.getInstance().uId;
      }


      DatabaseReference modelUserInfoReference = ManageFirebaseDatabase
          .reference.child('model_comic_detail_info').child('likes');
      modelUserInfoReference.once().then((DataSnapshot snapshot) {
        print('[PacketC2SLikeComic:fetchFireBaseDB ] - ${snapshot
            .value}');

        (respondPacket as PacketS2CLikeComic).parseFireBaseDBJson(snapshot.value, onFetchDone);

        return true;
      });
    }


    return false;
  }


}