import 'dart:io';
import 'dart:typed_data';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_logout.dart';


typedef void OnPacketLogoutFetchDone(PacketS2CLogout packet);


class PacketC2SLogout extends PacketC2SCommon
{
  String _socialId;
  String _emailAddress;
  e_social_provider_type _socialProviderType;

  PacketC2SLogout()
  {
    type = e_packet_type.c2s_logout;
  }

  void generate(String socialId,String emailAddress,e_social_provider_type socialProviderType)
  {
    _socialId = socialId;
    _emailAddress = emailAddress;
    _socialProviderType = socialProviderType;
  }

  void fetchBytes(onPacketLogoutFetchDone) async
  {
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CLogout packet = new PacketS2CLogout();
      packet.parseBytes(event);
      onPacketLogoutFetchDone(packet);
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