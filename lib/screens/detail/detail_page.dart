import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'package:sparky/screens/common_widgets.dart';
import 'package:sparky/screens/detail/detail_widgets.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_storage_file_real_url.dart';
import 'package:sparky/packets/packet_c2s_finish_message.dart';
import 'package:sparky/packets/packet_s2c_subscribe_comic.dart';

class DetailPage extends StatefulWidget {
  final String _creatorId;
  final String _comicNumber;
  String _partNumber = '001';
  String _seasonNumber = '001';
  DetailPage(this._creatorId, this._comicNumber,this._partNumber,this._seasonNumber);
  bool _Liked = true;

  @override
  _DetailPageState createState() => _DetailPageState(_creatorId, _comicNumber,_partNumber,_seasonNumber);
}

class _DetailPageState extends State<DetailPage> with WidgetsBindingObserver {
  final String _creatorId;
  final String _comicNumber;
  String _partNumber = '001';
  String _seasonNumber = '001';
  ScrollController controller;
  bool _Liked = true;
  int _LikeCount = 41;
  Timer _timer;
  List<PacketC2SCommon> _messageList;


  _DetailPageState(this._creatorId, this._comicNumber,this._partNumber,this._seasonNumber);

  PacketC2SComicDetailInfo c2sComicDetailInfo = new PacketC2SComicDetailInfo();


//Todo need to implement lazy loading
  /*
 Future _loadMore() async
 {
    setState(() {
      isLoading = true;
    });

    // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 2));
    for (var i = currentLength; i <= currentLength + increment; i++) {
      data.add(i);
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }
*/


  @override
  void initState()
  {
    print('[detail : initState]');

    WidgetsBinding.instance.addObserver(this);
    super.initState();

    if(null == _messageList)
      _messageList = new List<PacketC2SCommon>();
    Duration duration = new Duration(milliseconds: 100);
    if(null == _timer)
      _timer = new Timer.periodic(duration, update);

    init();
  }

  @override
  void dispose() {

    print('[detail : dispose]');

    PacketC2SFinishMessage packet = new PacketC2SFinishMessage();
    _messageList.add(packet);


    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  void init() async
  {
    print('[detail : init] - creatorid : $_creatorId , comicNumber : $_comicNumber ');

    c2sComicDetailInfo.generate(_creatorId, _comicNumber,_partNumber,_seasonNumber);
    c2sComicDetailInfo.fetch(_onFetchDone);
  }


  void _onFetchDone(PacketCommon packetCommon)
  {
    print('[detail : _onFetchDone] - ${packetCommon.type.toString()}');
    PacketS2CCommon packetS2CCommon = packetCommon as PacketS2CCommon;

    switch(packetCommon.type)
    {

      default:
        break;
    }


    setState(() {

    });
  }


  void update(Timer timer)
  {
    //print('start current time : ${timer.tick}');
    if(null != _messageList)
    {
      if (0 < _messageList.length)
      {
        PacketC2SCommon packetC2SCommon = _messageList[0];

        switch (packetC2SCommon.type)
        {
          case e_packet_type.c2s_comic_detail_info:
            {
              PacketC2SComicDetailInfo packet = packetC2SCommon as PacketC2SComicDetailInfo;
              packet.fetch(null);
              _messageList.removeAt(0);
            }
            break;

          case e_packet_type.c2s_storage_file_real_url:
            {
              PacketC2SStorageFileRealUrl packet = packetC2SCommon as PacketC2SStorageFileRealUrl;
              packet.fetch(null);
              _messageList.removeAt(0);
            }
            break;

          case e_packet_type.c2s_finish_message:
            {
              _messageList.removeAt(0);
              if(null != _timer)
              {
                _timer.cancel();
                _timer = null;
              }
            }
            break;

          default:
            break;
        }
      }
    }
  }


  Future<bool> _onBackPressed() async
  {
    print('_onBackPressed');

    // await showDialog or Show add banners or whatever
    // then
    return true; // return true if the route to be popped
  }


  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: new  Scaffold(
         appBar: PreferredSize(
            preferredSize:
            Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
            child: SafeArea(
              child: AppBar(
                elevation: 1,
                iconTheme: IconThemeData(
                color: Colors.black, //change your color here
    ),
    backgroundColor: Colors.white, //Color.fromRGBO(21, 24, 45, 1.0),
    //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
    // centerTitle: true,
    leading: new IconButton(
    icon: new Icon(Icons.arrow_back),
    onPressed: () {

      print('onPressed');
      return Navigator.pop(context);
      },
    ),
    title: FittedBox(
    fit: BoxFit.fitWidth,
    child: SizedBox(
    width: ManageDeviceInfo.resolutionWidth * 0.7,
    child: ModelComicDetailInfo.getInstance().titleName == null
    ? Text(
    'Loading...',
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.start,
    style: TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.bold,
    fontSize: ManageDeviceInfo.resolutionHeight * 0.025,
    color: Colors.black87,
    ),
    )
        : Text(
    ModelComicDetailInfo.getInstance().titleName,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.start,
    style: TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.bold,
    fontSize: ManageDeviceInfo.resolutionHeight * 0.025,
    color: Colors.black87,
    ),
    ),
    ),
    ),

    ),
    ),
    ),
    body: SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: ModelComicDetailInfo.getInstance().representationImageUrl == null
    ? LoadingIndicator()
        : new DetailHeaderWidget(c2sComicDetailInfo: c2sComicDetailInfo),
    ),
    )
    );


    /*
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
        child: SafeArea(
          child: AppBar(
            elevation: 1,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white, //Color.fromRGBO(21, 24, 45, 1.0),
            //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            // centerTitle: true,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                width: ManageDeviceInfo.resolutionWidth * 0.7,
                child: ModelComicDetailInfo.getInstance().mainTitleName == null
                    ? Text(
                        'Loading...',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          fontSize: ManageDeviceInfo.resolutionHeight * 0.025,
                          color: Colors.black87,
                        ),
                      )
                    : Text(
                        ModelComicDetailInfo.getInstance().mainTitleName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          fontSize: ManageDeviceInfo.resolutionHeight * 0.025,
                          color: Colors.black87,
                        ),
                      ),
              ),
            ),
            
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ModelComicDetailInfo.getInstance().representationImageUrl == null
            ? LoadingIndicator()
            : new DetailHeaderWidget(c2sComicDetailInfo: c2sComicDetailInfo),
      ),
    );
    */


  // void _scrollListener() {
  //  print(controller.position.extentAfter);
  //  if (controller.position.extentAfter < 500) {
  //    setState(() {
  //      items.addAll(new List.generate(42, (index) => 'Inserted $index'));
  //    });
  //  }
  //}
  }
}

class DetailHeaderWidget extends StatelessWidget {
  const DetailHeaderWidget({
    Key key,
    @required this.c2sComicDetailInfo,
  }) : super(key: key);

  final PacketC2SComicDetailInfo c2sComicDetailInfo;
  
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: ManageDeviceInfo.resolutionHeight * 0.02,
          ),
          new DeatilHeaderTitleWidget(
            titleThumnailUrl: ModelComicDetailInfo.getInstance().representationImageUrl,
            titleName: ModelComicDetailInfo.getInstance().titleName,
            creatorName: ModelComicDetailInfo.getInstance().creatorName
          ),
          Divider(),
          new ViewFrom1stEpisodeWidget(
            userId: ModelComicDetailInfo.getInstance().userId,
            comicId: ModelComicDetailInfo.getInstance().comicNumber,
            firstEpisodeId: ModelPreset.convertCountIndex2EpisodeId(0),
          ),
          Divider(),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  ManageDeviceInfo.resolutionWidth * 0.02,
                  0.0,
                  0.0,
                  0.0),
              child: SizedBox(
                width: ManageDeviceInfo.resolutionWidth * 0.8,
                child: Text(
                  '줄거리',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    fontSize: ManageDeviceInfo.resolutionHeight * 0.021,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
          new StorylineTextBoxWidget(storyText: ModelComicDetailInfo.getInstance().explain,),
          Divider(),
          Padding(
            padding: EdgeInsets.only(top: ManageDeviceInfo.resolutionHeight * 0.00),
            //              height: ManageDeviceInfo.resolutionHeight * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LikedIconWidget(),
                SaveToViewListIcon(),
                ShareIconWidget(),
                StoryTranslationIconWidget(iconText:'번역하기'),
              ]),
          ),
          Divider(),
          new EpisodeTotalNumberDisplayWidget(episodeCount: ModelComicDetailInfo.getInstance().modelComicInfoLength,),
          SizedBox(
            height: ManageDeviceInfo.resolutionHeight * 0.02,
          ),
          new EpisodeListViewWidget(c2sComicDetailInfo: c2sComicDetailInfo),
        ],
      );
  }
}





