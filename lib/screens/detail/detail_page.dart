import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'package:sparky/screens/common_widgets.dart';
import 'package:sparky/screens/detail/detail_widgets.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
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
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    init();
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

  void init() async {
    c2sComicDetailInfo.generate(_creatorId, _comicNumber,_partNumber,_seasonNumber);
    c2sComicDetailInfo.fetch(_onFetchDone);
  }


  void _onFetchDone(PacketCommon packetCommon)
  {
    print('[detail_page] : onFetchDone');
    PacketS2CCommon packetS2CCommon = packetCommon as PacketS2CCommon;





    setState(() {

    });
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





