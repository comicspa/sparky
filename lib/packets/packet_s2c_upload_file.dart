import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_utility.dart';

class PacketS2CUploadFile extends PacketS2CCommon
{

  PacketS2CUploadFile()
  {
    type = e_packet_type.s2c_upload_file;
  }

  void parseBytes(List<int> event)
  {
    status = e_packet_status.start_dispatch_respond;
    parseHeader(event);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type');
    status = e_packet_status.finish_dispatch_respond;

  }

}

