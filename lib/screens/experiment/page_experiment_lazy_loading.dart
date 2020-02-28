import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/models/model_localization_info.dart';
import 'package:sparky/models/model_today_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_today_trend_comic_info.dart';
import 'package:sparky/models/model_featured_comic_info.dart';
import 'package:sparky/packets/packet_c2s_featured_comic_info.dart';
import 'package:sparky/models/model_recommended_comic_info.dart';
import 'package:sparky/packets/packet_c2s_recommended_comic_info.dart';
import 'package:sparky/models/model_new_comic_info.dart';
import 'package:sparky/packets/packet_c2s_new_comic_info.dart';
import 'package:sparky/models/model_real_time_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_real_time_trend_comic_info.dart';
import 'package:sparky/models/model_weekly_trend_comic_info.dart';
import 'package:sparky/packets/packet_c2s_weekly_trend_comic_info.dart';
import 'package:sparky/screens/common_widgets.dart';
import 'package:sparky/screens/detail/detail_page.dart';
import 'package:transparent_image/transparent_image.dart';



class PageExperimentLazyLoading extends StatefulWidget {
  @override
  _PageExperimentLazyLoadingState createState() => new _PageExperimentLazyLoadingState();
}

class _PageExperimentLazyLoadingState extends State<PageExperimentLazyLoading> with WidgetsBindingObserver {
  PacketC2STodayTrendComicInfo c2STodayTrendComicInfo =
  new PacketC2STodayTrendComicInfo(); // use this to handle data
  PacketC2SFeaturedComicInfo c2sFeaturedComicInfo =
  new PacketC2SFeaturedComicInfo(); // use this to handle data
  PacketC2SRecommendedComicInfo c2sRecommendedComicInfo =
  new PacketC2SRecommendedComicInfo();
  PacketC2SNewComicInfo c2sNewComicInfo = new PacketC2SNewComicInfo();
  PacketC2SRealTimeTrendComicInfo c2sRealTimeTrendInfo =
  new PacketC2SRealTimeTrendComicInfo();
  PacketC2SWeeklyTrendComicInfo c2sWeeklyTrendComicInfo =
  new PacketC2SWeeklyTrendComicInfo();

  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // generating packet

    c2STodayTrendComicInfo.generate(null);
    c2sFeaturedComicInfo.generate(null);
    c2sRecommendedComicInfo.generate(null);
    c2sNewComicInfo.generate(null);
    c2sRealTimeTrendInfo.generate(null);
    c2sWeeklyTrendComicInfo.generate(null);

    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    // for pull to refresh
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
        child: SafeArea(
          child: AppBar(
            elevation: 1,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white, //Color.fromRGBO(21, 24, 45, 1.0),
            //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            centerTitle: true,

            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                width: ManageDeviceInfo.resolutionWidth * 0.7,
                child: Text(
                  'Lazy test',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    fontSize: ManageDeviceInfo.resolutionHeight * 0.025,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            /*SvgPicture.asset(
              'images/sparky_logo.svg',
              width: ManageDeviceInfo.resolutionWidth * 0.045,
              height: ManageDeviceInfo.resolutionHeight * 0.025,

            ),*/
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Todo need to add indicator for the CarouselSlider with auto scroll true
            /* SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: FutureBuilder<List<ModelFeaturedComicInfo>>(
                  future: c2sFeaturedComicInfo.fetch(null),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none &&
                        snapshot.hasData == null)
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
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'images/mainTest.jpg',
                                      image: i.thumbnailUrl,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    /* CachedNetworkImage(
                                                        imageUrl: i.thumbnailUrl,
                                                        placeholder: (context, url) =>
                                                            LoadingIndicator(),
                                                        fit: BoxFit.fitWidth), */
                                    onTap: () {
                                      Navigator.push<Widget>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                              i.userId, i.comicId), // link to Actual viewer
                                        ),
                                      );
                                    },
                                  ),
                                );
                              });
                            }).toList(),
                            autoPlay: false,
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
                                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
            ), */

            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(15, 5, 0, 2),
              child: Text(
                'Recommended' /* ModelLocalizationInfo.getText('trend','recommended') */,
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
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) =>
                    FutureBuilder<List<ModelRecommendedComicInfo>>(
                      future: c2sRecommendedComicInfo.fetch(null),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData == null){
                          return Center(child: LoadingIndicator());
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push<Widget>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(snapshot.data[index].creatorId,
                                        snapshot.data[index].comicNumber, snapshot.data[index].partNumber, snapshot.data[index].seasonNumber), // link to Actual viewer
                                  ),
                                );
                              },
                              child: Container(
                                child: FittedBox(
                                  child: Material(
                                    color: Colors.white,
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.circular(4.0),
                                    shadowColor: Color(0x802196F3),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: ManageDeviceInfo.resolutionWidth * 0.41,
                                          height: ManageDeviceInfo.resolutionHeight * 0.15,
                                          child: ClipRRect(
                                            borderRadius: new BorderRadius.circular(2.0),
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: snapshot.data[index].url == null ? LinearProgressIndicator : snapshot.data[index].url,
                                              fit: BoxFit.cover,
                                              height: ManageDeviceInfo.resolutionHeight * 0.15,
                                            ),
                                            /* CachedNetworkImage(
                                          imageUrl: snapshot.data[index].thumbnailUrl,
                                          placeholder: (context, url) => LoadingIndicator(),
                                          fit: BoxFit.cover,
                                          height: ManageDeviceInfo.resolutionHeight * 0.15,
                                        ), */
                                          ),
                                        ),
                                        SizedBox(height: ManageDeviceInfo.resolutionHeight * 0.002),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ManageDeviceInfo.resolutionWidth * 0.01),
                                          height: ManageDeviceInfo.resolutionHeight * 0.048,
                                          width: ManageDeviceInfo.resolutionWidth * 0.41,
                                          child: Text(
                                            snapshot.data[index].titleName == null ? '' : snapshot.data[index].titleName,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.bold,
                                              fontSize: ManageDeviceInfo.resolutionHeight * 0.019,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: ManageDeviceInfo.resolutionHeight * 0.002),
                                        Container(
                                          width: ManageDeviceInfo.resolutionWidth * 0.41,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height: ManageDeviceInfo.resolutionHeight * 0.042,
                                                width: ManageDeviceInfo.resolutionWidth * 0.20,
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    snapshot.data[index].creatorId == null ? '' : snapshot.data[index].creatorId,
                                                    textAlign: TextAlign.right,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize:
                                                      ManageDeviceInfo.resolutionHeight * 0.018,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: ManageDeviceInfo.resolutionWidth * 0.02,
                                              ),
                                              Container(
                                                height: ManageDeviceInfo.resolutionHeight * 0.032,
                                                child: Icon(
                                                  Icons.remove_red_eye,
                                                  size: ManageDeviceInfo.resolutionHeight * 0.025,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                      ManageDeviceInfo.resolutionWidth * 0.02),
                                                  height: ManageDeviceInfo.resolutionHeight * 0.022,
                                                  width: ManageDeviceInfo.resolutionWidth * 0.22,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                      '250,589,938', //Todo need to create 조회수 data
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.right,
                                                      style: TextStyle(
                                                        fontFamily: 'Lato',
                                                        color: Colors.black87,
                                                        fontSize:
                                                        ManageDeviceInfo.resolutionHeight *
                                                            0.018,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );

                        }
                      },
                    ),
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
              child: FutureBuilder<List<ModelRealTimeTrendComicInfo>>(
                  future: c2sRealTimeTrendInfo.fetch(null),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
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
                    } else {
                      return Container(
                        child: TrendCardList(snapshot: snapshot,),
                      );

                    }

                  }

              ),
            ),


            /*  Container(
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
                future: c2sNewComicInfo.fetch(null),
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
                future: c2STodayTrendComicInfo.fetch(null),
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
                future: c2sWeeklyTrendComicInfo.fetch(null),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return LoadingIndicator();
                  {
                    return TrendCardList(snapshot: snapshot);
                  }
                },
              ),
            ), */
          ],
        ),
      ),
    );
  }

  Column mainBannerWidget(
      AsyncSnapshot<List<ModelFeaturedComicInfo>> snapshot) {
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
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: i.url,
                    fit: BoxFit.fitWidth,
                  ),
                  /* CachedNetworkImage(
                                      imageUrl: i.thumbnailUrl,
                                      placeholder: (context, url) =>
                                          LoadingIndicator(),
                                      fit: BoxFit.fitWidth), */
                  onTap: () {
                    Navigator.push<Widget>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                            i.creatorId, i.comicNumber,i.partNumber,i.seasonNumber), // link to Actual viewer
                      ),
                    );
                  },
                ),
              );
            });
          }).toList(),
          autoPlay: false,
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
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
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
    featuredComicsList.add(countBanner.elementAt(i).url);
    print(countBanner.elementAt(i).url);
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
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: i.thumbnailUrl,
          fit: BoxFit.cover,
        ), /* CachedNetworkImage(imageUrl: i.thumbnailUrl, fit: BoxFit.fill), */
      ),
    );
  },
).toList();

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
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push<Widget>(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(snapshot.data[index].creatorId,
                    snapshot.data[index].comicNumber,snapshot.data[index].partNumber,snapshot.data[index].seasonNumber), // link to Actual viewer
              ),
            );
          },
          child: Container(
            child: FittedBox(
              child: Material(
                color: Colors.white,
                elevation: 2.0,
                borderRadius: BorderRadius.circular(4.0),
                shadowColor: Color(0x802196F3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: ManageDeviceInfo.resolutionWidth * 0.41,
                      height: ManageDeviceInfo.resolutionHeight * 0.15,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(2.0),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: snapshot.data[index].thumbnailUrl,
                          fit: BoxFit.cover,
                          height: ManageDeviceInfo.resolutionHeight * 0.15,
                        ),
                        /* CachedNetworkImage(
                        imageUrl: snapshot.data[index].thumbnailUrl,
                        placeholder: (context, url) => LoadingIndicator(),
                        fit: BoxFit.cover,
                        height: ManageDeviceInfo.resolutionHeight * 0.15,
                      ), */
                      ),
                    ),
                    SizedBox(height: ManageDeviceInfo.resolutionHeight * 0.002),
                    Container(
                      padding: EdgeInsets.only(
                          left: ManageDeviceInfo.resolutionWidth * 0.01),
                      height: ManageDeviceInfo.resolutionHeight * 0.048,
                      width: ManageDeviceInfo.resolutionWidth * 0.41,
                      child: Text(
                        snapshot.data[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          fontSize: ManageDeviceInfo.resolutionHeight * 0.019,
                        ),
                      ),
                    ),
                    SizedBox(height: ManageDeviceInfo.resolutionHeight * 0.002),
                    Container(
                      width: ManageDeviceInfo.resolutionWidth * 0.41,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: ManageDeviceInfo.resolutionHeight * 0.042,
                            width: ManageDeviceInfo.resolutionWidth * 0.20,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                snapshot.data[index].userId,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize:
                                  ManageDeviceInfo.resolutionHeight * 0.018,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ManageDeviceInfo.resolutionWidth * 0.02,
                          ),
                          Container(
                            height: ManageDeviceInfo.resolutionHeight * 0.032,
                            child: Icon(
                              Icons.remove_red_eye,
                              size: ManageDeviceInfo.resolutionHeight * 0.025,
                              color: Colors.black54,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(
                                  right:
                                  ManageDeviceInfo.resolutionWidth * 0.02),
                              height: ManageDeviceInfo.resolutionHeight * 0.022,
                              width: ManageDeviceInfo.resolutionWidth * 0.22,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '250,589,938', //Todo need to create 조회수 data
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    color: Colors.black87,
                                    fontSize:
                                    ManageDeviceInfo.resolutionHeight *
                                        0.018,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
