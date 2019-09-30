import 'dart:io';

import 'package:sparky/manage/manage_firebase_auth.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_sign_out_with_social.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class PacketC2SSignOutWithSocial extends PacketC2SCommon
{
  e_social_provider_type _socialProviderType;

  PacketC2SSignOutWithSocial()
  {
    type = e_packet_type.c2s_sign_in_with_social;
  }

  void generate(e_social_provider_type socialProviderType)
  {
    _socialProviderType = socialProviderType;
  }

  Future<void> fetch(onFetchDone) async
  {
    switch(_socialProviderType)
    {

      default:
        break;
    }

    return _fetchGoogle(onFetchDone);
  }

  Future<void> _fetchGoogle(onFetchDone) async
  {
    GoogleSignIn googleSignIn = ManageFirebaseAuth.processGoogleSignIn();

    if(false == await googleSignIn.isSignedIn())
      return false;

    await googleSignIn.signOut();

    /*
    //set
    ModelUserInfo.getInstance().socialProviderType = e_social_provider_type.none;
    ModelUserInfo.getInstance().displayName = '';
    ModelUserInfo.getInstance().photoUrl = '';
    ModelUserInfo.getInstance().email = '';
    ModelUserInfo.getInstance().uId = '';
    print('signOutWithGoogle : ${ModelUserInfo.getInstance().toString()}');

     */

    PacketS2CSignOutWithSocial packet = new PacketS2CSignOutWithSocial();
    packet.parseGoogle(onFetchDone);

    return true;
  }



}