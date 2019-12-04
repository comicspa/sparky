
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';

class PacketC2SFinishMessage extends PacketC2SCommon
{

  PacketC2SFinishMessage()
  {
    type = e_packet_type.c2s_finish_message;
  }

}