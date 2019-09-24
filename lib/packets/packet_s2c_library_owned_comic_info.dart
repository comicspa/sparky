import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_library_owned_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';



class PacketS2CLibraryOwnedComicInfo extends PacketS2CCommon
{
  PacketS2CLibraryOwnedComicInfo()
  {
    type = e_packet_type.s2c_library_owned_comic_info;
  }


  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelMyLockerComicOwnedCount = getUint32();
    print('modelMyLockerComicOwnedCount : $modelMyLockerComicOwnedCount');


    List<ModelLibraryOwnedComicInfo> list = new List<ModelLibraryOwnedComicInfo>();

    for(int countIndex=0; countIndex<modelMyLockerComicOwnedCount; ++countIndex)
    {
      ModelLibraryOwnedComicInfo modelLibraryOwnedComicInfo = new ModelLibraryOwnedComicInfo();

      modelLibraryOwnedComicInfo.userId = readStringToByteBuffer();
      modelLibraryOwnedComicInfo.comicId = readStringToByteBuffer();
      modelLibraryOwnedComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationVerticalImageDownloadUrl(modelLibraryOwnedComicInfo.userId, modelLibraryOwnedComicInfo.comicId);
      modelLibraryOwnedComicInfo.url = url;
      modelLibraryOwnedComicInfo.thumbnailUrl = url;

      modelLibraryOwnedComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryOwnedComicInfo.toString());

      list.add(modelLibraryOwnedComicInfo);
    }

    ModelLibraryOwnedComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }
}