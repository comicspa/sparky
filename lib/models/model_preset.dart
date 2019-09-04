import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:package_info/package_info.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/manage/manage_firebase_storage.dart';


enum e_comic_genre
{
  romance,

}



typedef void OnPresetFetchDone(bool result);


class ModelPreset
{
  static String __version = '1.0.0.0';
  static String _faqUrl = 'https://www.google.co.kr';
  static String _privacyPolicyUrl = 'https://www.google.co.kr';
  static String _termsOfUseUrl = 'https://www.google.co.kr';
  static final String _comicBaseUrl = 'comics';
  static final String __representationVerticalImageFileFullName = '000000.jpg';
  static final String __representationHorizontalImageFileFullName = '000001.jpg';
  static final String __thumbnailImageFileFullName = '00000.jpg';
  static final String __bannerImageFileFullName = '100000.jpg';

  static String get version => __version;
  static String get faqUrl => _faqUrl;
  static String get privacyPolicyUrl => _privacyPolicyUrl;
  static String get termsOfUseUrl => _termsOfUseUrl;
  static String get comicBaseUrl => _comicBaseUrl;
  static String get representationVerticalImageFileFullName => __representationVerticalImageFileFullName;
  static String get representationHorizontalImageFileFullName => __representationHorizontalImageFileFullName;
  static String get thumbnailImageFileFullName => __thumbnailImageFileFullName;
  static String get bannerImageFileFullName => __bannerImageFileFullName;

  static bool fromJson(String presetJsonString)
  {
    print('preset : '+presetJsonString);
    Map presetMap = jsonDecode(presetJsonString);

    String version = presetMap['version'];
    print('current version : $version , app version : $__version');

    PackageInfo.fromPlatform().then((PackageInfo packageInfo)
    {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      print('package version : $version , package buildNumber : $buildNumber');
    });
    if(0 != version.compareTo(__version))
      return false;


    var linkJson = presetMap['link'];
    _faqUrl = linkJson['faq'];
    print('faq : $_faqUrl');

    _privacyPolicyUrl = linkJson['privacy_policy'];
    print('privacy_policy : $_privacyPolicyUrl');

    _termsOfUseUrl = linkJson['terms_of_use'];
    print('terms_of_use : $_termsOfUseUrl');

    return true;

  }

  static void fetch(onPresetFetchDone)
  {
    HttpClient client = new HttpClient();
    client.getUrl(Uri.parse('${ModelCommon.storageServerBaseURL}/preset.txt')).then((
        HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      response.transform(utf8.decoder).listen((contents) {

        bool result = fromJson(contents);
        onPresetFetchDone(result);

      });
    });

  }


  static void fetch2(onPresetFetchDone) async
  {
    final ref = FirebaseStorage.instance.ref().child('presets/preset.txt');
    String url = await ref.getDownloadURL().then((value)
    {
      //value == ModelUserInfo.getInstance()
      print(value.toString());
      print('success');

      HttpClient client = new HttpClient();
      client.getUrl(Uri.parse(value)).then((
          HttpClientRequest request) {
        return request.close();
      }).then((HttpClientResponse response) {
        response.transform(utf8.decoder).listen((contents) {

          bool result = fromJson(contents);
          onPresetFetchDone(result);
        });
      });
    },
        onError: (error)
        {
          print('error : $error');
        }).catchError( (error)
    {
      print('catchError : $error');
    });


    /*
    String fileFullPathName = ManageFirebaseStorage.getDownloadURL();
    print('fileFullPathName : $fileFullPathName');

    HttpClient client = new HttpClient();
    client.getUrl(Uri.parse(fileFullPathName)).then((
        HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      response.transform(utf8.decoder).listen((contents) {

        fromJson(contents);
        onPresetFetchDone();
      });
    });
    */

  }


  static void test() async
  {
    final ref = FirebaseStorage.instance.ref().child('comics/01.jpg');

    String url = await ref.getDownloadURL().then((value)
    {
      //value == ModelUserInfo.getInstance()
      print(value.toString());
      print('success');

      HttpClient client = new HttpClient();
      client.getUrl(Uri.parse(value)).then((
          HttpClientRequest request) {
        return request.close();
      }).then((HttpClientResponse response) {
        response.listen((contents) {

          print('1.test : ${contents.length}');

        });
      });
    },
        onError: (error)
        {
          print('error : $error');
        }).catchError( (error)
    {
      print('catchError : $error');
    });
  }


  static Future<String> getRepresentationVerticalImageDownloadUrl(String userId,String comicId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$userId/$comicId/$representationVerticalImageFileFullName');
    print('getRepresentationVerticalImageDownloadUrl : $url');
    return url;
  }

  static Future<String> getRepresentationHorizontalImageDownloadUrl(String userId,String comicId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$userId/$comicId/$representationHorizontalImageFileFullName');
    print('getRepresentationHorizontalImageDownloadUrl : $url');
    return url;
  }


  static Future<String> getBannerImageDownloadUrl(String userId,String comicId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$userId/$comicId/$bannerImageFileFullName');
    print('getBannerImageDownloadUrl : $url');
    return url;
  }

  static Future<String> getThumbnailImageDownloadUrl(String userId,String comicId,String partId,String seasonId,String episodeId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$userId/$comicId/$partId/$seasonId/$episodeId/$thumbnailImageFileFullName');
    print('getThumbnailImageDownloadUrl : $url');
    return url;
  }

  static Future<String> getCutImageDownloadUrl(String userId,String comicId,String partId,String seasonId,String episodeId,String imageId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$userId/$comicId/$partId/$seasonId/$episodeId/$imageId.jpg');
    print('getCutImageDownloadUrl : $url');
    return url;
  }

  static String convertCountIndex2CutImageId(int countIndex)
  {
    return convertNumber2CutImageId(countIndex + 1);
  }

  static String convertNumber2CutImageId(int number)
  {
    String imageId;
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

    return imageId;
  }

}