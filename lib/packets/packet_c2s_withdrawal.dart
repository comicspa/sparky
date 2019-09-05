import 'dart:io';
import 'dart:typed_data';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/packets/packet_utility.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_withdrawal.dart';


typedef void OnPacketWithdrawalFetchDone(PacketS2CWithdrawal packet);


class PacketC2SWithdrawal extends PacketC2SCommon
{
  String _userId;

  PacketC2SWithdrawal()
  {
    type = e_packet_type.c2s_withdrawal;
  }

  void generate(String userId)
  {
    _userId = userId;
  }

  void fetchBytes(onPacketWithdrawalFetchDone) async
  {
    Socket socket = await ModelCommon.createServiceSocket();
    print('connected server');

    // listen to the received data event stream
    socket.listen((List<int> event)
    {
      PacketS2CWithdrawal packet = new PacketS2CWithdrawal();
      packet.parseBytes(event);
      onPacketWithdrawalFetchDone(packet);
    });

    List<int> userIdList = PacketUtility.readyWriteStringToByteBuffer(_userId);

    int packetBodySize  = PacketUtility.getStringTotalLength(userIdList);
    generateHeader(packetBodySize);

    writeStringToByteBuffer(userIdList);

    socket.add(packet);

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 5));
    socket.close();

  }

}