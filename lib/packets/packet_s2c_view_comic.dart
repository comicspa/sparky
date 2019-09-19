import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:sprintf/sprintf.dart';

import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/models/model_view_comic.dart';
import 'package:sparky/models/model_preset.dart';


class PacketS2CViewComic extends PacketS2CCommon
{
  PacketS2CViewComic()
  {
    type = e_packet_type.s2c_view_comic;
  }



  Future<void> parseBytes(int packetSize,ByteData byteDataExceptionSize,onFetchDone) async
  {
    parseHeaderChecked(packetSize,byteDataExceptionSize);

    systemErrorCode = getUint32();
    serviceErrorCode = getUint32();

    print('PackSize : $size , PacketType : $type , systemErrorCode : $systemErrorCode , serviceErrorCode : $serviceErrorCode');


    if(null == ModelViewComic.list)
      ModelViewComic.list = new List<ModelViewComic>();

    ModelViewComic modelViewComic;
    if(0 == ModelViewComic.list.length)
      modelViewComic = new ModelViewComic();
    else
      modelViewComic = ModelViewComic.list[0];

    modelViewComic.userId = readStringToByteBuffer();
    modelViewComic.id = readStringToByteBuffer();
    modelViewComic.episodeId = readStringToByteBuffer();
    modelViewComic.title = readStringToByteBuffer();
    modelViewComic.episodeCount = getUint32();
    switch(getUint32())
    {
      case 0:
        {
          modelViewComic.style = e_comic_view_style.vertical;
        }
        break;

      case 1:
        {
          modelViewComic.style = e_comic_view_style.horizontal;
        }
        break;
    }

    int comicCount = getUint32();
    print('cutImageCount : $comicCount');


    if(0 < comicCount)
    {
      if (null == modelViewComic.imageUrlList)
        modelViewComic.imageUrlList = new List<String>();
      else
        modelViewComic.imageUrlList.clear();
    }

    for(int countIndex=0; countIndex<comicCount; ++countIndex)
    {
      String imageId = '00001';
      //String imageId = sprintf('%05d', (countIndex+1));

      int number = countIndex + 1;

      if(number < 10)
        {
          imageId = '0000$number';
        }
      else if(9 < number && number < 100)
        {
          imageId = '000$number';
        }
      else if(99 < number && number < 1000)
      {
        imageId = '00$number';
      }
      else if(999 < number && number < 10000)
      {
        imageId = '0$number';
      }
      else if(9999 < number && number < 100000)
      {
        imageId = '$number';
      }

      print('imageId[$countIndex / $comicCount] : $imageId');

      String comicImageUrl =
        await ModelPreset.getCutImageDownloadUrl(modelViewComic.userId,modelViewComic.id,'001','001',modelViewComic.episodeId,imageId);

      print('comicImageUrl[$countIndex] : $comicImageUrl');

      modelViewComic.imageUrlList.add(comicImageUrl);
    }

    if(0 == ModelViewComic.list.length)
      ModelViewComic.list.add(modelViewComic);

    if(null != onFetchDone)
      onFetchDone(this);

  }



}
