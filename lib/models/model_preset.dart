import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:package_info/package_info.dart';

import 'package:sparky/models/model_common.dart';
import 'package:sparky/manage/manage_firebase_storage.dart';


class ModelPreset
{
  static String _version = '1.0.0.0';
  static String _homepageUrl = 'https://www.google.co.kr';
  static String _faqUrl = 'https://www.google.co.kr';
  static String _privacyPolicyUrl = 'https://www.google.co.kr';
  static String _termsOfUseUrl = 'https://www.google.co.kr';
  static String _termsOfUseTranslateComicUrl = 'https://www.google.co.kr';
  static String _termsOfUseRegisterComicUrl = 'https://www.google.co.kr';
  static bool _developerMode = false;
  static final String _comicBaseUrl = 'comics';
  static final String __representationHorizontalImageFileFullName = '000000.jpg';
  static final String __representationSquareImageFileFullName = '000001.jpg';
  static final String __thumbnailImageFileFullName = '00000.jpg';
  static final String __bannerImageFileFullName = '100000.jpg';

  static String get version => _version;
  static String get homepageUrl => _homepageUrl;
  static String get faqUrl => _faqUrl;
  static String get privacyPolicyUrl => _privacyPolicyUrl;
  static String get termsOfUseUrl => _termsOfUseUrl;
  static String get termsOfUseTranslateComicUrl => _termsOfUseTranslateComicUrl;
  static String get termsOfUseRegisterComicUrl => _termsOfUseRegisterComicUrl;
  static String get comicBaseUrl => _comicBaseUrl;
  static String get representationHorizontalImageFileFullName => __representationHorizontalImageFileFullName;
  static String get representationSquareImageFileFullName => __representationSquareImageFileFullName;
  static String get thumbnailImageFileFullName => __thumbnailImageFileFullName;
  static String get bannerImageFileFullName => __bannerImageFileFullName;
  static bool get developerMode => _developerMode;

  static set homepageUrl(String homepageUrl)
  {
    _homepageUrl = homepageUrl;
  }
  static set faqUrl(String faqUrl)
  {
    _faqUrl = faqUrl;
  }
  static set privacyPolicyUrl(String privacyPolicyUrl)
  {
    _privacyPolicyUrl = privacyPolicyUrl;
  }
  static set termsOfUseUrl(String termsOfUseUrl)
  {
    _termsOfUseUrl = termsOfUseUrl;
  }
  static set termsOfUseTranslateComicUrl(String termsOfUseTranslateComicUrl)
  {
    _termsOfUseTranslateComicUrl = termsOfUseTranslateComicUrl;
  }
  static set termsOfUseRegisterComicUrl(String termsOfUseRegisterComicUrl)
  {
    _termsOfUseRegisterComicUrl = termsOfUseRegisterComicUrl;
  }

  static set developerMode(bool developerMode)
  {
    _developerMode = developerMode;
  }

  static bool fromJson(String presetJsonString)
  {
    print('preset : '+presetJsonString);
    Map presetMap = jsonDecode(presetJsonString);

    String version = presetMap['version'];
    print('current version : $version , app version : $_version');

    PackageInfo.fromPlatform().then((PackageInfo packageInfo)
    {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String packageVersion = packageInfo.version;
      String packageBuildNumber = packageInfo.buildNumber;

      print('appName : $appName , packageName : $packageName , packageVersion : $packageVersion , packageBuildNumber : $packageBuildNumber');
    });
    if(0 != version.compareTo(_version))
      return false;


    var linkJson = presetMap['link'];
    _faqUrl = linkJson['faq'];
    print('faq : $_faqUrl');

    _privacyPolicyUrl = linkJson['privacy_policy'];
    print('privacy_policy : $_privacyPolicyUrl');

    _termsOfUseUrl = linkJson['terms_of_use'];
    print('terms_of_use : $_termsOfUseUrl');

    _termsOfUseRegisterComicUrl = linkJson['terms_of_use_register_comic'];
    print('terms_of_use_register_comic : $_termsOfUseRegisterComicUrl');

    _termsOfUseTranslateComicUrl = linkJson['terms_of_use_translate_comic'];
    print('terms_of_use_translate_comic : $_termsOfUseTranslateComicUrl');

    return true;

  }

  static void fetch(onPresetFetchDone)
  {
    HttpClient client = new HttpClient();
    client.getUrl(Uri.parse('${ModelCommon.testStorageServerBaseURL}/preset.txt')).then((
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


  static Future<String> getRepresentationHorizontalImageDownloadUrl(String creatorId,String comicId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$creatorId/$comicId/$representationHorizontalImageFileFullName');
    print('getRepresentationHorizontalImageDownloadUrl : $url');
    return url;
  }

  static Future<String> getRepresentationSquareImageDownloadUrl(String creatorId,String comicId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$creatorId/$comicId/$representationSquareImageFileFullName');
    print('getRepresentationSquareImageDownloadUrl : $url');
    return url;
  }


  static Future<String> getBannerImageDownloadUrl(String creatorId,String comicId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$creatorId/$comicId/$bannerImageFileFullName');
    print('getBannerImageDownloadUrl : $url');
    return url;
  }

  static Future<String> getThumbnailImageDownloadUrl(String creatorId,String comicId,String partId,String seasonId,String episodeId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$creatorId/$comicId/$partId/$seasonId/$episodeId/$thumbnailImageFileFullName');
    print('getThumbnailImageDownloadUrl : $url');
    return url;
  }

  static Future<String> getCutImageDownloadUrl(String creatorId,String comicId,String partId,String seasonId,String episodeId,String imageId) async
  {
    String url  = await ManageFirebaseStorage.getDownloadUrl('$comicBaseUrl/$creatorId/$comicId/$partId/$seasonId/$episodeId/$imageId.jpg');
    print('getCutImageDownloadUrl : $url');
    return url;
  }

  static String convertCountIndex2EpisodeId(int countIndex)
  {
    return convertNumber2EpisodeId(countIndex + 1);
  }

  static String convertNumber2EpisodeId(int number)
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