import 'dart:io';

import 'package:sparky/manage/manage_firebase_auth.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_sign_in_with_social.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class PacketC2SSignInWithSocial extends PacketC2SCommon
{
  e_social_provider_type _socialProviderType;

  PacketC2SSignInWithSocial()
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

    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential authCredential = GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(authCredential);

    //print('userMail : ${user.email}');
    //print('userDisplayName : ${user.displayName}');

    //assert(user.email != null);
    //assert(user.displayName != null);
    //assert(!user.isAnonymous);
    //assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    PacketS2CSignInWithSocial packet = new PacketS2CSignInWithSocial();
    packet.parseGoogle(currentUser,onFetchDone);

  }



}