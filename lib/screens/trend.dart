import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:sparky/manage/manage_message.dart';
import 'package:sparky/models/model_localization_info.dart';
import 'package:sparky/packets/packet_s2c_storage_file_real_url.dart';
import 'package:transparent_image/transparent_image.dart';
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
import 'package:sparky/screens/detail/detail_page.dart';
import 'common_widgets.dart';
import 'package:sparky/manage/manage_firebase_messaging.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_storage_file_real_url.dart';


class Trend extends StatefulWidget {
  @override
  _TrendState createState() => new _TrendState();
}

class _TrendState extends State<Trend> with WidgetsBindingObserver {

  Stream<PacketS2CCommon> _broadcastStream;

  PacketC2STodayTrendComicInfo _packetC2STodayTrendComicInfo = new PacketC2STodayTrendComicInfo(); // use this to handle data
  PacketC2SFeaturedComicInfo _packetC2SFeaturedComicInfo = new PacketC2SFeaturedComicInfo(); // use this to handle data
  PacketC2SRecommendedComicInfo _packetC2SRecommendedComicInfo = new PacketC2SRecommendedComicInfo();
  PacketC2SNewComicInfo _packetC2SNewComicInfo = new PacketC2SNewComicInfo();
  PacketC2SRealTimeTrendComicInfo _packetC2SRealTimeTrendInfo = new PacketC2SRealTimeTrendComicInfo();
  PacketC2SWeeklyTrendComicInfo _packetC2SWeeklyTrendComicInfo = new PacketC2SWeeklyTrendComicInfo();
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  /*
  void _onFetchDone(PacketS2CCommon packetS2CPacket)
  {
    print('[Trend] : _onFetchDone');
    if(e_packet_status.finish_dispatch_respond != packetS2CPacket.status)
      return;

    switch(packetS2CPacket.type)
    {
      case e_packet_type.s2c_storage_file_real_url:
        {
            PacketS2CStorageFileRealUrl packet = packetS2CPacket as PacketS2CStorageFileRealUrl;
            if(packet.isFinished())
            {
              print('packet.isFinished() - ${packet.modelName}');

              switch(packet.modelName)
              {
                case ModelFeaturedComicInfo.ModelName:
                  {
                    //_packetC2SStorageFileRealUrl.generate(ModelRecommendedComicInfo.ModelName);
                    //_packetC2SStorageFileRealUrl.fetch(_onFetchDone);
                  }
                  break;

                case ModelRecommendedComicInfo.ModelName:
                  {
                    //_packetC2SStorageFileRealUrl.generate(ModelRealTimeTrendComicInfo.ModelName);
                    //_packetC2SStorageFileRealUrl.fetch(_onFetchDone);
                  }
                  break;

                case ModelRealTimeTrendComicInfo.ModelName:
                  {
                    //_packetC2SStorageFileRealUrl.generate(ModelNewComicInfo.ModelName);
                    //_packetC2SStorageFileRealUrl.fetch(_onFetchDone);
                  }
                  break;

                case ModelNewComicInfo.ModelName:
                  {
                    //_packetC2SStorageFileRealUrl.generate(ModelTodayTrendComicInfo.ModelName);
                    //_packetC2SStorageFileRealUrl.fetch(_onFetchDone);
                  }
                  break;

                case ModelTodayTrendComicInfo.ModelName:
                  {
                    //_packetC2SStorageFileRealUrl.generate(ModelWeeklyTrendComicInfo.ModelName);
                    //_packetC2SStorageFileRealUrl.fetch(_onFetchDone);
                  }
                  break;

                case ModelWeeklyTrendComicInfo.ModelName:
                  {

                  }
                  break;

                default:
                  break;

              }
            }
        }
        break;

      default:
        break;
    }

    setState(() {

    });

  }
  */

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    ManageFireBaseMessaging.initialize();
    // generating packet

    //_packetC2STodayTrendComicInfo.generate(0, 0,false);
    //_packetC2SFeaturedComicInfo.generate(0, 0,false);
    //_packetC2SRecommendedComicInfo.generate(0, 0);
    //_packetC2SNewComicInfo.generate(0, 0,false);
    //_packetC2SRealTimeTrendInfo.generate(0, 0,false);
    //_packetC2SWeeklyTrendComicInfo.generate(0, 0,false);

    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    // for pull to refresh

    _broadcastStream = ManageMessage.streamController.stream;
    _broadcastStream.listen((data)
    {
      print("DataReceived1: " + data.type.toString());

      switch (data.type)
      {
        case e_packet_type.s2c_featured_comic_info:
          {
            _packetC2SRecommendedComicInfo.generate();
            ManageMessage.add(_packetC2SRecommendedComicInfo);
          }
          break;

        case e_packet_type.s2c_recommended_comic_info:
          {
            _packetC2SRealTimeTrendInfo.generate();
            ManageMessage.add(_packetC2SRealTimeTrendInfo);
          }
          break;

        case e_packet_type.s2c_real_time_trend_comic_info:
          {
            _packetC2SNewComicInfo.generate();
            ManageMessage.add(_packetC2SNewComicInfo);
          }
          break;

        case e_packet_type.s2c_new_comic_info:
          {
            _packetC2STodayTrendComicInfo.generate();
            ManageMessage.add(_packetC2STodayTrendComicInfo);
          }
          break;

        case e_packet_type.s2c_today_trend_comic_info:
          {
            _packetC2SWeeklyTrendComicInfo.generate();
            ManageMessage.add(_packetC2SWeeklyTrendComicInfo);
          }
          break;

        case e_packet_type.s2c_weekly_trend_comic_info:
          {
            PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
            packetC2SStorageFileRealUrl.generate(ModelFeaturedComicInfo.ModelName);
            ManageMessage.add(packetC2SStorageFileRealUrl);
          }
          break;

        case e_packet_type.s2c_storage_file_real_url:
          {
            PacketS2CStorageFileRealUrl packet = data as PacketS2CStorageFileRealUrl;
            switch(packet.modelName)
            {
              case ModelFeaturedComicInfo.ModelName:
                {
                  PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                  packetC2SStorageFileRealUrl.generate(ModelRecommendedComicInfo.ModelName);
                  ManageMessage.add(packetC2SStorageFileRealUrl);
                }
                break;

              case ModelRecommendedComicInfo.ModelName:
                {
                  PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                  packetC2SStorageFileRealUrl.generate(ModelRealTimeTrendComicInfo.ModelName);
                  ManageMessage.add(packetC2SStorageFileRealUrl);
                }
                break;

              case ModelRealTimeTrendComicInfo.ModelName:
                {
                  PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                  packetC2SStorageFileRealUrl.generate(ModelNewComicInfo.ModelName);
                  ManageMessage.add(packetC2SStorageFileRealUrl);
                }
                break;

              case ModelNewComicInfo.ModelName:
                {
                  PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                  packetC2SStorageFileRealUrl.generate(ModelTodayTrendComicInfo.ModelName);
                  ManageMessage.add(packetC2SStorageFileRealUrl);
                }
                break;

              case ModelTodayTrendComicInfo.ModelName:
                {
                  PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                  packetC2SStorageFileRealUrl.generate(ModelWeeklyTrendComicInfo.ModelName);
                  ManageMessage.add(packetC2SStorageFileRealUrl);
                }
                break;

              case ModelWeeklyTrendComicInfo.ModelName:
                {

                }
                break;

              default:
                break;
            }

            setState(() {

            });
          }
          break;

        default:
          break;
      }
    });


    if(null == ModelFeaturedComicInfo.list)
    {
      _packetC2SFeaturedComicInfo.generate();
      ManageMessage.add(_packetC2SFeaturedComicInfo);
    }
    else if(null == ModelRecommendedComicInfo.list)
    {
      _packetC2SRecommendedComicInfo.generate();
      ManageMessage.add(_packetC2SRecommendedComicInfo);

    }
    else if(null == ModelRealTimeTrendComicInfo.list)
    {
      _packetC2SRealTimeTrendInfo.generate();
      ManageMessage.add(_packetC2SRealTimeTrendInfo);
    }
    else if(null == ModelNewComicInfo.list)
    {
      _packetC2SNewComicInfo.generate();
      ManageMessage.add(_packetC2SNewComicInfo);
    }
    else if(null == ModelTodayTrendComicInfo.list)
    {
      _packetC2STodayTrendComicInfo.generate();
      ManageMessage.add(_packetC2STodayTrendComicInfo);
    }
    else if(null == ModelWeeklyTrendComicInfo.list)
    {
      _packetC2SWeeklyTrendComicInfo.generate();
      ManageMessage.add(_packetC2SWeeklyTrendComicInfo);
    }
    else
     {
       PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
       packetC2SStorageFileRealUrl.generate(ModelFeaturedComicInfo.ModelName);
      ManageMessage.add(packetC2SStorageFileRealUrl);
    }
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
                future: _packetC2SFeaturedComicInfo.fetch(null),
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
                                  child: null != i.url ? FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: i.url,
                                    fit: BoxFit.cover,
                                    height: ManageDeviceInfo.resolutionHeight * 0.15,
                                  )
                                      : Image.asset('images/Comi.png'),
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
                                            i.creatorId,
                                            i.comicNumber), // link to Actual viewer
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
            child: Text(ModelLocalizationInfo.getText('trend', 'title_1') //Recommended
               /* ModelLocalizationInfo.getText('trend','recommended') */,
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
              future: _packetC2SRecommendedComicInfo.fetch(null),
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
              ModelLocalizationInfo.getText('trend', 'title_2'), //Realtime Trend
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
              future: _packetC2SRealTimeTrendInfo.fetch(null),
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
              ModelLocalizationInfo.getText('trend', 'title_3'), //New Comics
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
              future: _packetC2SNewComicInfo.fetch(null),
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
            child: Text(ModelLocalizationInfo.getText('trend', 'title_5'), //Today's Trend
              
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
              future: _packetC2STodayTrendComicInfo.fetch(null),
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
              ModelLocalizationInfo.getText('trend', 'title_4'), //Weekly Trend
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
              future: _packetC2SWeeklyTrendComicInfo.fetch(null),
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



String checkTitle(int type) {
  String title;
  

  switch (type) {
    case 1:
    {
      title = 'title_1'; //Recommended
    }
    break;
    case 2:    
    {
      title = 'title_2'; //Realtime Trend
    }
    break;
    case 3:
    {
      title = 'title_3'; // New Comics
    }
    break;
    case 4:
    {
      title = 'title_4'; // Today Trend
    }
    break;
    case 5:
    {
      title = 'title_5'; // Weekly Trend
    }
    break;
    
    default:
    {
      title = 'title_2'; // Realtime Trend
    }
    break;
  }

  return title;
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
        child:
        null != i.url ? FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: i.url,
          fit: BoxFit.cover,
          height: ManageDeviceInfo.resolutionHeight * 0.15,
        )
            : Image.asset('images/Comi.png')
        /*FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: i.thumnailUrl,
          fit: BoxFit.fill,
        )*/
        /* CachedNetworkImage(imageUrl: i.thumbnailUrl, fit: BoxFit.fill), */
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
                builder: (context) => DetailPage(
                    snapshot.data[index].creatorId,
                    snapshot.data[index]
                        .comicNumber), // link to Actual viewer
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
                        child: null != snapshot.data[index].url ? FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: snapshot.data[index].url,
                          fit: BoxFit.cover,
                          height: ManageDeviceInfo.resolutionHeight * 0.15,
                        )
                            : Image.asset('images/Comi.png')
                        /* CachedNetworkImage(
                          imageUrl: snapshot.data[index].url,
                          placeholder: (context, url) => LoadingIndicator(),
                          fit: BoxFit.cover,
                          height: ManageDeviceInfo.resolutionHeight * 0.15,
                        ) */,
                      ),
                    ),
                    SizedBox(
                      height: ManageDeviceInfo.resolutionHeight * 0.002), 
                    Container(
                      padding: EdgeInsets.only(left: ManageDeviceInfo.resolutionWidth * 0.01),
                      height: ManageDeviceInfo.resolutionHeight * 0.048,
                      width: ManageDeviceInfo.resolutionWidth * 0.41,                    
                      child: Text(snapshot.data[index].titleName,
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
                    SizedBox(
                      height: ManageDeviceInfo.resolutionHeight * 0.002), 
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
                                snapshot.data[index].creatorName,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: ManageDeviceInfo.resolutionHeight * 0.018,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                ManageDeviceInfo.resolutionWidth * 0.02,
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
                              padding: EdgeInsets.only(right: ManageDeviceInfo.resolutionWidth * 0.02),
                              height: ManageDeviceInfo.resolutionHeight * 0.022,
                              width: ManageDeviceInfo.resolutionWidth * 0.22,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${snapshot.data[index].viewCount}', 
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    color: Colors.black87,
                                    fontSize: ManageDeviceInfo.resolutionHeight * 0.018,
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