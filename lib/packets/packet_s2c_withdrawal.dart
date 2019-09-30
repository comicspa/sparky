import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';


class PacketS2CWithdrawal extends PacketS2CCommon
{
  PacketS2CWithdrawal()
  {
    type = e_packet_type.s2c_withdrawal;
  }

  Future<void> parseFireBaseDBJson(onFetchDone) async
  {

    if(null != onFetchDone)
      onFetchDone(this);
  }

  void parseBytes(List<int> event)
  {
    parseHeader(event);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type');

  }

}