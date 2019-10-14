import 'dart:io';

import 'package:sparky/manage/manage_firebase_auth.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_sign_out_with_social.dart';


class PacketC2SSignOutWithSocial extends PacketC2SCommon
{
  e_social_provider_type _socialProviderType;

  PacketC2SSignOutWithSocial()
  {
    type = e_packet_type.c2s_sign_out_with_social;
  }

  void generate(e_social_provider_type socialProviderType)
  {
    _socialProviderType = socialProviderType;
  }

  Future<void> fetch(onFetchDone) async
  {
    switch(_socialProviderType)
    {
      case e_social_provider_type.google:
        {
          _fetchGoogle(onFetchDone);

        }
        break;

      default:
        break;
    }

  }

  Future<void> _fetchGoogle(onFetchDone) async
  {
    ManageFirebaseAuth.googleSignOut();

    PacketS2CSignOutWithSocial packet = new PacketS2CSignOutWithSocial();
    packet.parseGoogle(onFetchDone);

    return true;
  }



}