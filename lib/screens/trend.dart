import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_today_trend_comic_info.dart';
import 'package:sparky/models/model_featured_comic_info.dart';
import 'package:sparky/packets/packet_c2s_featured_comic_info.dart';
import 'package:sparky/models/model_recommended_comic_info.dart';
import 'package:sparky/packets/packet_c2s_recommended_comic_info.dart';
import 'package:sparky/models/model_new_comic_info.dart';
import 'package:sparky/packets/packet_c2s_new_comic_info.dart';
import 'package:sparky/models/model_real_time_trend_info.dart';
import 'package:sparky/packets/packet_c2s_real_time_trend_info.dart';
import 'package:sparky/models/model_weekly_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_weekly_trend_comic_info.dart';
import 'detail_page.dart';
import 'common_widgets.dart';

class Trend extends StatefulWidget {
  @override
  _TrendState createState() => new _TrendState();
}

class _TrendState extends State<Trend> with WidgetsBindingObserver {
  PacketC2STodayTrendComicInfo c2STodayTrendComicInfo =
      new PacketC2STodayTrendComicInfo(); // use this to handle data
  PacketC2SFeaturedComicInfo c2sFeaturedComicInfo =
      new PacketC2SFeaturedComicInfo(); // use this to handle data
  PacketC2SRecommendedComicInfo c2sRecommendedComicInfo =
      new PacketC2SRecommendedComicInfo();
  PacketC2SNewComicInfo c2sNewComicInfo = new PacketC2SNewComicInfo();
  PacketC2SRealTimeTrendInfo c2sRealTimeTrendInfo =
      new PacketC2SRealTimeTrendInfo();
  PacketC2SWeeklyTrendComicInfo c2sWeeklyTrendComicInfo =
      new PacketC2SWeeklyTrendComicInfo();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // generating packet

    c2STodayTrendComicInfo.generate(0, 0);
    c2sFeaturedComicInfo.generate(0, 0);
    c2sRecommendedComicInfo.generate(0, 0);
    c2sNewComicInfo.generate(0, 0);
    c2sRealTimeTrendInfo.generate(0, 0);
    c2sWeeklyTrendComicInfo.generate(0, 0);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  int _current = 0; // this is for indicator handler

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //Todo need to add indicator for the CarouselSlider with auto scroll true
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: FutureBuilder<List<ModelFeaturedComicInfo>>(
                future: c2sFeaturedComicInfo.fetchBytes(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: LoadingIndicator());

                  {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CarouselSlider(
                          items: snapshot.data.map((i) {
                            return Builder(builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 0.0),
                                decoration: BoxDecoration(color: Colors.white),
                                child: GestureDetector(
                                  child: CachedNetworkImage(
                                      imageUrl: i.thumbnailUrl,
                                      placeholder: (context, url) =>
                                          LoadingIndicator(),
                                      fit: BoxFit.fitWidth),
                                  onTap: () {
                                    Navigator.push<Widget>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                            i.userId,
                                            i.comicId), // link to Actual viewer
                                      ),
                                    );
                                  },
                                ),
                              );
                            });
                          }).toList(),
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 1.4,
                          onPageChanged: (index) {
                            setState(() {
                              _current = index;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(
                            ModelFeaturedComicInfo.list,
                            (index, i) {
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
                                        ? Color.fromRGBO(0, 0, 0, 0.9)
                                        : Color.fromRGBO(0, 0, 0, 0.4)),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(15, 5, 0, 2),
            child: Text(
              'Recommended',
              style: TextStyle(
                  fontSize: ManageDeviceInfo.resolutionHeight * 0.024,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            height: ManageDeviceInfo.resolutionHeight * 0.28,
            child: FutureBuilder<List<ModelRecommendedComicInfo>>(
              future: c2sRecommendedComicInfo.fetchBytes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return new LoadingIndicator();
                {
                  return TrendCardList(snapshot: snapshot);
                }
              },
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(15, 20, 0, 2),
            child: Text(
              'Realtime Trend',
              style: TextStyle(
                  fontSize: ManageDeviceInfo.resolutionHeight * 0.024,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            height: ManageDeviceInfo.resolutionHeight * 0.28,
            child: FutureBuilder<List<ModelRealTimeTrendInfo>>(
              future: c2sRealTimeTrendInfo.fetchBytes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: ManageDeviceInfo.resolutionHeight * .25,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  );
                {
                  return TrendCardList(snapshot: snapshot);
                }
              },
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
            child: Text(
              'New Comics',
              style: TextStyle(
                  fontSize: ManageDeviceInfo.resolutionHeight * 0.024,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            height: ManageDeviceInfo.resolutionHeight * 0.28,
            child: FutureBuilder<List<ModelNewComicInfo>>(
              future: c2sNewComicInfo.fetchBytes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LoadingIndicator();
                {
                  return TrendCardList(snapshot: snapshot);
                }
              },
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
            child: Text(
              'Today\'s Trend',
              style: TextStyle(
                  fontSize: ManageDeviceInfo.resolutionHeight * 0.024,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            height: ManageDeviceInfo.resolutionHeight * 0.28,
            child: FutureBuilder<List<ModelTodayTrendComicInfo>>(
              future: c2STodayTrendComicInfo.fetchBytes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LoadingIndicator();
                {
                  return TrendCardList(snapshot: snapshot);
                }
              },
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(15, 20, 0, 5),
            child: Text(
              'Weekly Trend',
              style: TextStyle(
                  fontSize: ManageDeviceInfo.resolutionHeight * 0.024,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.all(0),
            height: ManageDeviceInfo.resolutionHeight * 0.28,
            child: FutureBuilder<List<ModelWeeklyTrendComicInfo>>(
              future: c2sWeeklyTrendComicInfo.fetchBytes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LoadingIndicator();
                {
                  return TrendCardList(snapshot: snapshot);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Todo apply refreshIndicator to refresh with pull swipe

/* RefreshIndicator(
  key: _refreshIndicatorKey,
  onRefresh: refresh,
  child: ListView.builder(
    children: [

    ]
  )
), */




class TrendCardList extends StatelessWidget {
  const TrendCardList({
    Key key,
    @required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    List<dynamic> values = snapshot.data;
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) => Card(
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: ManageDeviceInfo.resolutionWidth * 0.45,
              height: ManageDeviceInfo.resolutionHeight * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2.0),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data[index].thumbnailUrl,
                      placeholder: (context, url) => LoadingIndicator(),
                      fit: BoxFit.fill,
                      height: ManageDeviceInfo.resolutionHeight * 0.15,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height:
                                    ManageDeviceInfo.resolutionHeight * 0.048,
                                child: Text(
                                  snapshot.data[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ManageDeviceInfo.resolutionHeight *
                                            0.019,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: ManageDeviceInfo.resolutionHeight *
                                      0.018), // used for spacing purpose
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: ManageDeviceInfo.resolutionHeight *
                                        0.032,
                                    width:
                                        ManageDeviceInfo.resolutionWidth * 0.22,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data[index].userId,
                                        textAlign: TextAlign.right,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: ManageDeviceInfo
                                                  .resolutionHeight *
                                              0.018,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        ManageDeviceInfo.resolutionWidth * 0.02,
                                  ),
                                  SizedBox(
                                    height: ManageDeviceInfo.resolutionHeight *
                                        0.032,
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      size: ManageDeviceInfo.resolutionHeight *
                                          0.025,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height:
                                          ManageDeviceInfo.resolutionHeight *
                                              0.032,
                                      width: ManageDeviceInfo.resolutionWidth *
                                          0.22,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '250,589', //Todo need to create 조회수 data
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            color: Colors.black54,
                                            fontSize: ManageDeviceInfo
                                                    .resolutionHeight *
                                                0.018,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )))
                ],
              ),
            ),
            Positioned.fill(
              // added to display the inkwell effect properly when Card and other widgets are used together
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.push<Widget>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                            snapshot.data[index].userId,
                            snapshot
                                .data[index].comicId), // link to Actual viewer
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Need handler for indicator
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

// Take only 6 creatorFeaturedList

final List<String> featuredComicsList = [];

List<String> countBanner(List<ModelFeaturedComicInfo> countBanner) {
  // Todo Need to change this "TodayPopularComicInfo" to Creator Featured
  print('countBanner start');

  if (null == countBanner) return null;

  int count = countBanner.length;
  if (count > 6) count = 6;

  for (int i = 0; i < count; ++i) {
    featuredComicsList.add(countBanner.elementAt(i).thumbnailUrl);
    print(countBanner.elementAt(i).thumbnailUrl);
  }

  return featuredComicsList;
}

List bannerList = map<Widget>(
  featuredComicsList,
  (index, i) {
    return Container(
      height: 300,
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: CachedNetworkImage(imageUrl: i.thumbnailUrl, fit: BoxFit.fill),
      ),
    );
  },
).toList();
