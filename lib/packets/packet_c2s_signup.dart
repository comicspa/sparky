import 'dart:io';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_signup.dart';


typedef void OnPacketSignupFetchDone(PacketS2CSignup packet);


class PacketC2SSignUp extends PacketC2SCommon
{
  String _socialId;
  String _emailAddress;
  e_social_provider_type _socialProviderType;

  PacketC2SSignUp()
  {
    type = e_packet_type.c2s_signup;
  }

  void generate(String socialId,String emailAddress,e_social_provider_type socialProviderType)
  {
    _socialId = socialId;
    _emailAddress = emailAddress;
    _socialProviderType = socialProviderType;
  }

  void fetchBytes(onPacketSignupFetchDone) async
  {
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CSignup packet = new PacketS2CSignup();
      packet.parseBytes(event);
      onPacketSignupFetchDone(packet);
    });


    List<int> socialIdList = PacketUtility.readyWriteStringToByteBuffer(_socialId);
    List<int> emailAddressList = PacketUtility.readyWriteStringToByteBuffer(_emailAddress);
    int socialProviderTypeIndex = _socialProviderType.index;

    int packetBodySize  = PacketUtility.getStringTotalLength(socialIdList) + PacketUtility.getStringTotalLength(emailAddressList) + 4;
    generateHeader(packetBodySize);

    writeStringToByteBuffer(socialIdList);
    writeStringToByteBuffer(emailAddressList);
    setUint32(socialProviderTypeIndex);

    socket.add(packet);

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

  }

}