import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PacketS2CSignInWithSocial extends PacketS2CCommon
{
  PacketS2CSignInWithSocial()
  {
    type = e_packet_type.s2c_sign_in_with_social;
  }


  Future<void> parseGoogle(FirebaseUser user,onFetchDone) async
  {
    ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.google;
    ModelUserInfo.getInstance().displayName = user.displayName;
    ModelUserInfo.getInstance().photoUrl = user.photoUrl;
    ModelUserInfo.getInstance().email = user.email;
    ModelUserInfo.getInstance().uId = user.uid;

    print('signInWithGoogle : ${ModelUserInfo.getInstance().toString()}');

    if(null != onFetchDone)
      onFetchDone(this);
  }





}