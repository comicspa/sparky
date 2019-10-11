
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_check_sign_up.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sparky/manage/manage_firebase_database.dart';


class PacketC2SCheckSignUp extends PacketC2SCommon
{
  String _userId;

  PacketC2SCheckSignUp()
  {
    type = e_packet_type.c2s_check_sign_up;
  }

  void generate(String userId)
  {
    _userId = userId;
  }

  Future<String> fetch(onFetchDone) async
  {
    return _fetchFireBaseDB(onFetchDone);
  }

  Future<String> _fetchFireBaseDB(onFetchDone) async
  {
    print('PacketC2SCheckSignUp : fetchFireBaseDB started');
    DatabaseReference modelUserInfoReference = ManageFirebaseDatabase.reference.child('model_user_info');
    modelUserInfoReference.child(_userId).once().then((DataSnapshot snapshot)
    {
      print('[PacketC2SCheckSignUp : _fetchFireBaseDB ] - ${snapshot.value}');

      PacketS2CCheckSignUp packetS2CCheckSignUp = new PacketS2CCheckSignUp();
      packetS2CCheckSignUp.parseFireBaseDBJson(snapshot.value, onFetchDone);

    });

    return null;
  }


}