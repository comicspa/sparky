import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_today_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_view_comic.dart';
import 'package:sparky/packets/packet_c2s_featured_comic_info.dart';
import 'package:sparky/packets/packet_c2s_new_comic_info.dart';
import 'package:sparky/packets/packet_c2s_weekly_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_real_time_trend_info.dart';
import 'package:sparky/packets/packet_c2s_recommended_comic_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_new_creator_info.dart';
import 'package:sparky/packets/packet_c2s_weekly_creator_info.dart';
import 'package:sparky/packets/packet_c2s_library_view_list_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_continue_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_owned_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_recent_comic_info.dart';
import 'package:sparky/packets/packet_c2s_user_info.dart';

import 'package:sparky/manage/manage_common.dart';
import 'package:sparky/manage/manage_firebase_auth.dart';
import 'package:sparky/manage/manage_firebase_ml_vision.dart';
import 'package:sparky/manage/manage_firebase_storage.dart';
import 'package:sparky/manage/manage_paint_canvas.dart';
import 'package:sparky/manage/manage_access_token.dart';

import 'package:sparky/models/model_view_comic.dart';

class PageDevTest extends StatefulWidget {
  @override
  _PageDevTestState createState() => new _PageDevTestState();
}

class _PageDevTestState extends State<PageDevTest> {
  int selectedCountIndex = -1;
  AsyncSnapshot snapshot;

  PacketC2STodayTrendComicInfo c2STodayTrendComicInfo = new PacketC2STodayTrendComicInfo();
  PacketC2SWeeklyTrendComicInfo c2SWeeklyTrendComicInfo = new PacketC2SWeeklyTrendComicInfo();
  PacketC2SFeaturedComicInfo c2SFeaturedComicInfo = new PacketC2SFeaturedComicInfo();
  PacketC2SViewComic c2SViewComic = new PacketC2SViewComic();
  PacketC2SNewComicInfo c2SNewComicInfo = new PacketC2SNewComicInfo();
  PacketC2SRealTimeTrendInfo c2SRealTimeTrendInfo = new PacketC2SRealTimeTrendInfo();
  PacketC2SRecommendedComicInfo c2SRecommendedComicInfo = new PacketC2SRecommendedComicInfo();
  PacketC2SComicDetailInfo c2SComicDetailInfo = new PacketC2SComicDetailInfo();
  PacketC2SNewCreatorInfo c2SNewCreatorInfo = new PacketC2SNewCreatorInfo();
  PacketC2SWeeklyCreatorInfo c2SWeeklyCreatorInfo = new PacketC2SWeeklyCreatorInfo();
  PacketC2SLibraryViewListComicInfo c2SLibraryViewListComicInfo = new PacketC2SLibraryViewListComicInfo();
  PacketC2SLibraryContinueComicInfo c2SLibraryContinueComicInfo = new PacketC2SLibraryContinueComicInfo();
  PacketC2SLibraryOwnedComicInfo c2SLibraryOwnedComicInfo = new PacketC2SLibraryOwnedComicInfo();
  PacketC2SLibraryRecentComicInfo c2SLibraryRecentComicInfo = new PacketC2SLibraryRecentComicInfo();
  PacketC2SUserInfo c2sUserInfo = new PacketC2SUserInfo();

  @override
  void initState() {
    super.initState();

    //checkPermissionGetMultiFilePath();

    c2STodayTrendComicInfo.generate(0, 0);
    c2SWeeklyTrendComicInfo.generate(0, 0);
    c2SFeaturedComicInfo.generate(0, 0);
    c2SViewComic.generate('1566811403000', '000001', '00001');
    c2SNewComicInfo.generate(0, 0);
    c2SRealTimeTrendInfo.generate(0, 0);
    c2SRecommendedComicInfo.generate(0, 0);
    c2SComicDetailInfo.generate('1566811403000', '000001');
    c2SNewCreatorInfo.generate();
    c2SWeeklyCreatorInfo.generate();
    c2sUserInfo.generate();

    //ManageAccessToken.test();

    /*
    ManageFirebaseStorage.getDownloadUrl('comics/1566265967000/01/0000.jpg').then((value)
    {
      //value == String
      print(value.toString());
      print('getDownloadUrl success');
    },
        onError: (error)
        {
          print('getDownloadUrl error : $error');
        }).catchError( (error)
    {
      print('getDownloadUrl catchError : $error');
    });
    */
  }

  /*
  @override
  void initState() {
    super.initState();
    var sunImage = new NetworkImage(
        "https://resources.ninghao.org/images/childhood-in-a-picture.jpg");
    sunImage.obtainKey(new ImageConfiguration()).then((val) {
      var load = sunImage.load(val);
      load.addListener((listener, err) async {
        setState(() => image = listener);
      });
    });
  }
  */

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
                    ManageFirebaseStorage.simpleUsageUploadFile('ooo');
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
              c2sUserInfo.fetchBytes();
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

              /*
              new Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  top: 0.0,
                  child: new CustomPaint(
                    painter: new ManagePaintCanvas(),
                  )
              ),
              */
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
              //future:c2SFeaturedComicInfo.fetchBytes(),
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

        /*
        Expanded(
          child: FutureBuilder(
              future: getRegions(selectedCountry),
              initialData: [],
              builder: (context, snapshot) {
                return createRegionsListView(context, snapshot);
              }),
        ),
        */
      ]),

      /*
      body: CustomScrollView(
        slivers: <Widget>[

          SliverPadding(
            padding: EdgeInsets.all(16.20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Card(
                    child: new InkWell(
                      onTap: () {
                        print("SignUp Tapped");

                        _signInWithGoogle();

                      },
                      child: Container(

                        width: 100.0,
                        height: 50.0,
                        color:Color.fromARGB(255, 128, 128, 128),

                        child:Text("SignUp",),

                      ),
                    ),
                  ),


                  Card(
                    child: new InkWell(
                      onTap: () {
                        print("Withdrawal Tapped");
                      },
                      child: Container(

                        width: 100.0,
                        height: 50.0,
                        color:Color.fromARGB(255, 255, 255, 0),

                        child:Text("Withdrawal",),

                      ),
                    ),
                  ),

                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                  Card(
                    child: Text('data'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      */
    );
  }
}
