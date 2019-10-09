import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_today_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_view_comic.dart';
import 'package:sparky/packets/packet_c2s_new_comic_info.dart';
import 'package:sparky/packets/packet_c2s_weekly_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_real_time_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_recommended_comic_info.dart';
import 'package:sparky/packets/packet_c2s_new_creator_info.dart';
import 'package:sparky/packets/packet_c2s_weekly_creator_info.dart';
import 'package:sparky/packets/packet_c2s_library_view_list_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_continue_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_owned_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_recent_comic_info.dart';
import 'package:sparky/packets/packet_c2s_user_info.dart';

import 'package:sparky/manage/manage_common.dart';
import 'package:sparky/manage/manage_firebase_auth.dart';
import 'package:sparky/manage/manage_tflite.dart';
import 'package:sparky/manage/manage_firebase_ml_vision.dart';
import 'package:sparky/manage/manage_firebase_storage.dart';
import 'package:sparky/manage/manage_firebase_database.dart';
import 'package:sparky/manage/manage_paint_canvas.dart';
import 'package:sparky/manage/manage_access_token.dart';

import 'package:sparky/models/model_view_comic.dart';
import 'package:sparky/screens/test/page_dev_test_tflite.dart';
import 'package:sparky/screens/test/page_dev_test_account.dart';
import 'package:sparky/screens/test/page_dev_test_toast_message.dart';
import 'package:sparky/screens/test/page_dev_test_packet.dart';
import 'package:sparky/screens/test/page_dev_test_view_image.dart';
import 'package:sparky/screens/test/page_dev_test_shared_preference.dart';
import 'package:sparky/screens/test/page_dev_test_translation_page.dart';
import 'package:sparky/screens/test/page_dev_test_localization.dart';


class PageDevTestMenu extends StatefulWidget
{
  @override
  _PageDevTestMenuState createState() => new _PageDevTestMenuState();
}

class _PageDevTestMenuState extends State<PageDevTestMenu>
{

  @override
  void initState()
  {
    super.initState();

    String millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch.toString();
    print('millisecondsSinceEpoch : $millisecondsSinceEpoch');
  }



  // TODO Add build() method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dev Test Page Menu'),
      ),
      body: _buildSuggestions(context),
    );
  }


  Widget
  _buildSuggestions(BuildContext context)
  {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [

          ListTile(
            title: Text('Go to Next Page !!'),
            onTap: (){

              Navigator.of(context).pushReplacementNamed('/PageDevTestApply');

            },
          ),

          ListTile(
            title: Text('ToastMessage Test'),
            onTap: (){

              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDevTestToastMessage(
                  ),
                ),
              );

            },
          ),

          ListTile(
            title: Text('TFLite Test'),
            onTap: (){

              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDevTestTFLite(
                  ),
                ),
              );

            },
          ),
          ListTile(
            title: Text('Account Test'),
            onTap: (){

              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDevTestAccount(
                  ),
                ),
              );

            },
          ),

          ListTile(
            title: Text('Packet Test'),
            onTap: (){

              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDevTestPacket(
                  ),
                ),
              );

            },
          ),

          ListTile(
            title: Text('Language Selector'),
            onTap: (){

              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDevTestPacket(),
                ),
              );

            },
          ),

          ListTile(
            title: Text('View Image'),
            onTap: (){

              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDevTestViewImage(),
                ),
              );

            },
          ),

          ListTile(
            title: Text('SharedPreference Test'),
            onTap: (){

              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDevTestSharedPreference(),
                ),
              );

            },
          ),

          ListTile(
            title: Text('Translation List View'),
            onTap: (){

              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => TranslationListScreen(),
                ),
              );

            },
          ),

          ListTile(
            title: Text('Localization Test'),
            onTap: (){

              Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => PageDevTestLocalization(
                  ),
                ),
              );

            },
          ),

        ], ).toList(), ); }

}





/*
class PageDevTest extends StatefulWidget {
  @override
  _PageDevTestState createState() => new _PageDevTestState();
}

class _PageDevTestState extends State<PageDevTest> {
  int selectedCountIndex = -1;
  AsyncSnapshot snapshot;

  PacketC2STodayTrendComicInfo c2STodayTrendComicInfo = new PacketC2STodayTrendComicInfo();
  PacketC2SWeeklyTrendComicInfo c2SWeeklyTrendComicInfo = new PacketC2SWeeklyTrendComicInfo();
  PacketC2SViewComic c2SViewComic = new PacketC2SViewComic();
  PacketC2SNewComicInfo c2SNewComicInfo = new PacketC2SNewComicInfo();
  PacketC2SRealTimeTrendInfo c2SRealTimeTrendInfo = new PacketC2SRealTimeTrendInfo();
  PacketC2SRecommendedComicInfo c2SRecommendedComicInfo = new PacketC2SRecommendedComicInfo();
  PacketC2SNewCreatorInfo c2SNewCreatorInfo = new PacketC2SNewCreatorInfo();
  PacketC2SWeeklyCreatorInfo c2SWeeklyCreatorInfo = new PacketC2SWeeklyCreatorInfo();
  PacketC2SLibraryViewListComicInfo c2SLibraryViewListComicInfo = new PacketC2SLibraryViewListComicInfo();
  PacketC2SLibraryContinueComicInfo c2SLibraryContinueComicInfo = new PacketC2SLibraryContinueComicInfo();
  PacketC2SLibraryOwnedComicInfo c2SLibraryOwnedComicInfo = new PacketC2SLibraryOwnedComicInfo();
  PacketC2SLibraryRecentComicInfo c2SLibraryRecentComicInfo = new PacketC2SLibraryRecentComicInfo();
  PacketC2SUserInfo c2sUserInfo = new PacketC2SUserInfo();

  ];

  @override
  void initState() {
    super.initState();

    //checkPermissionGetMultiFilePath();

    c2STodayTrendComicInfo.generate(0, 0);
    c2SWeeklyTrendComicInfo.generate(0, 0);
    c2SViewComic.generate('1566811403000', '000001', '00001');
    c2SNewComicInfo.generate(0, 0);
    c2SRealTimeTrendInfo.generate(0, 0);
    c2SRecommendedComicInfo.generate(0, 0);
    c2SComicDetailInfo.generate('1566811403000', '000001');
    c2SNewCreatorInfo.generate();
    c2SWeeklyCreatorInfo.generate();
    c2sUserInfo.generate();

    //ManageAccessToken.test();

    //ManageFirebaseStorage.getDownloadUrl('comics/1566265967000/01/0000.jpg').then((value)
    //{

   //   print(value.toString());
   //   print('getDownloadUrl success');
   // },
     //   onError: (error)
     //   {
     //     print('getDownloadUrl error : $error');
     //   }).catchError( (error)
   // {
   //   print('getDownloadUrl catchError : $error');
   // });

    //ManageFirebaseDatabase.create();
    //ManageFirebaseDatabase.update();
    //ManageFirebaseDatabase.testRead();
  }



  Widget createTodayPopularComicInfoListView(
      BuildContext context, AsyncSnapshot snapshot) {
    var values = snapshot.data;
    if (null == values)
      print('null == values');
    else
      print('values.length = ${values.length}');

    return ListView.builder(
      itemCount: values == null ? 0 : values.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCountIndex = index;
              print('$index: ${values[index].url}');

              switch (selectedCountIndex) {
                case 0:
                  {
                    ManageFirebaseAuth.simpleUsageSignInWithGoogle();
                  }
                  break;

                case 1:
                  {
                    ManageCommon.detectTextFromFilePicker(true);
                  }
                  break;

                case 2:
                  {
                    //ManageFirebaseStorage.simpleUsageUploadFile('ooo');
                    ManageTFLite.readbyImagePicker();
                  }
                  break;

                case 3:
                  {}
                  break;
              }

              //c2SComicDetailInfo.fetchBytes();
              //c2SViewComic.fetchBytes();
              //c2SNewCreatorInfo.fetchBytes();
              //c2SWeeklyCreatorInfo.fetchBytes();
              //c2SMyLockerComicViewList.fetchBytes();
              //c2SMyLockerComicContinue.fetchBytes();
              //c2SMyLockerComicOwned.fetchBytes();
              //c2SMyLockerComicRecent.fetchBytes();
              c2sUserInfo.fetchBytes(_onFetchDone);
            });

            //print(selectedCountIndex);
          },
          child: Column(
            children: <Widget>[
              new ListTile(
                title: Text(values[index].title),
                selected: index == selectedCountIndex,
              ),
              Divider(
                height: 2.0,
              ),

            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Expanded(
          child: FutureBuilder(
              future: c2STodayTrendComicInfo.fetchBytes(),
              //future:c2SNewComicInfo.fetchBytes(),
              //future:c2SViewComic.fetchBytes(),
              //future:c2SWeeklyPopularComicInfo.fetchBytes(),
              //future:c2SRealTimeTrendInfo.fetchBytes(),
              //future:c2SRecommendedComicInfo.fetchBytes(),
              //future:c2sComicDetailInfo.fetchBytes(),
              initialData: [],
              builder: (context, snapshot) {
                this.snapshot = snapshot;
                return createTodayPopularComicInfoListView(context, snapshot);
              }),
        ),


      ]),
    );
  }
}

 */
