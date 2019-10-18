import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sparky/manage/manage_shared_preference.dart';

class PacketS2CSignInWithSocial extends PacketS2CCommon
{
  PacketS2CSignInWithSocial()
  {
    type = e_packet_type.s2c_sign_in_with_social;
  }


  Future<void> parseGoogle(FirebaseUser user,onFetchDone) async
  {
    status = e_packet_status.start_dispatch_respond;

    ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.google;
    ModelUserInfo.getInstance().displayName = user.displayName;
    ModelUserInfo.getInstance().photoUrl = user.photoUrl;
    ModelUserInfo.getInstance().email = user.email;
    ModelUserInfo.getInstance().uId = user.uid;

    print('signInWithGoogle : ${ModelUserInfo.getInstance().toString()}');


    ManageSharedPreference.setString('uId',user.uid);
    ManageSharedPreference.setInt('social_provider_type',ModelUserInfo.getInstance().socialProviderType.index);

    status = e_packet_status.finish_dispatch_respond;
    if(null != onFetchDone)
      onFetchDone(this);
  }





}