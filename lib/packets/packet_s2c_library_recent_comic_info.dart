import 'dart:typed_data';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_library_recent_comic_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/manage/manage_resource.dart';


class PacketS2CLibraryRecentComicInfo extends PacketS2CCommon
{
  PacketS2CLibraryRecentComicInfo()
  {
    type = e_packet_type.s2c_library_recent_comic_info;
  }

  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');

    int modelMyLockerComicRecentCount = getUint32();
    print('modelMyLockerComicRecentCount : $modelMyLockerComicRecentCount');


    List<ModelLibraryRecentComicInfo> list = new List<ModelLibraryRecentComicInfo>();

    for(int countIndex=0; countIndex<modelMyLockerComicRecentCount; ++countIndex)
    {
      ModelLibraryRecentComicInfo modelLibraryRecentComicInfo = new ModelLibraryRecentComicInfo();

      modelLibraryRecentComicInfo.userId = readStringToByteBuffer();
      modelLibraryRecentComicInfo.comicId = readStringToByteBuffer();
      modelLibraryRecentComicInfo.title = readStringToByteBuffer();

      String url = await ModelPreset.getRepresentationVerticalImageDownloadUrl(modelLibraryRecentComicInfo.userId, modelLibraryRecentComicInfo.comicId);
      modelLibraryRecentComicInfo.url = url;
      modelLibraryRecentComicInfo.thumbnailUrl = url;

      modelLibraryRecentComicInfo.image = await ManageResource.fetchImage(url);

      print(modelLibraryRecentComicInfo.toString());

      list.add(modelLibraryRecentComicInfo);
    }

    ModelLibraryRecentComicInfo.list = list;

    if(null != onFetchDone)
      onFetchDone(this);
  }

}