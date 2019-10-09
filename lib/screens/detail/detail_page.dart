import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/screens/viewer.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'package:sparky/screens/common_widgets.dart';
import 'package:sparky/screens/detail/detail_widgets.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/packets/packet_s2c_common.dart';

class DetailPage extends StatefulWidget {
  final String _userId;
  final String _comicId;
  DetailPage(this._userId, this._comicId);
  bool _Liked = true;
  

  @override
  _DetailPageState createState() => _DetailPageState(_userId, _comicId);
}

class _DetailPageState extends State<DetailPage> with WidgetsBindingObserver {
  final String _userId;
  final String _comicId;
  bool _Liked = true;
  int _LikeCount = 41;


  _DetailPageState(this._userId, this._comicId);

  PacketC2SComicDetailInfo c2sComicDetailInfo = new PacketC2SComicDetailInfo();
  // PacketC2SCommon ddd = new PacketC2SComicDetailInfo();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // generating packet
    // (ddd as PacketC2SComicDetailInfo).fetch(null);
    // c2sComicDetailInfo.fetch(null);


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
    c2sComicDetailInfo.generate(_userId, _comicId);
    c2sComicDetailInfo.fetch(_onFetchDone);
  }

  void _onFetchDone(PacketS2CCommon s2cPacket)
  {
    print('[detail_page] : onFetchDone');
    setState(() {

    });
  }

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
              color: Colors.black, //change your color here
            ),
            backgroundColor: Colors.white, //Color.fromRGBO(21, 24, 45, 1.0),
            //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            // centerTitle: true,

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
            titleName: ModelComicDetailInfo.getInstance().mainTitleName,
            creatorName: ModelComicDetailInfo.getInstance().creatorName
          ),
          Divider(),
          new ViewFrom1stEpisodeWidget(
            userId: ModelComicDetailInfo.getInstance().userId,
            comicId: ModelComicDetailInfo.getInstance().comicId,
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
          new EpisodeTotalNumberDisplayWidget(episodeCount: ModelComicDetailInfo.getInstance().modelComicInfoList,),
          SizedBox(
            height: ManageDeviceInfo.resolutionHeight * 0.02,
          ),
          new EpisodeListViewWidget(c2sComicDetailInfo: c2sComicDetailInfo),
        ],
      );
  }
}





