import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/screens/viewer.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'package:sparky/screens/common_widgets.dart';
import 'package:sparky/screens/detail/detail_widget.dart';
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
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: ManageDeviceInfo.resolutionHeight * 0.02,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              ManageDeviceInfo.resolutionWidth * 0.05,
                              ManageDeviceInfo.resolutionHeight * 0.0,
                              0,
                              ManageDeviceInfo.resolutionHeight * 0.01),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: CachedNetworkImage(
                              imageUrl: ModelComicDetailInfo.getInstance().representationImageUrl,
                              width: ManageDeviceInfo.resolutionWidth * 0.35,
                              height: ManageDeviceInfo.resolutionWidth * 0.35,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:  ManageDeviceInfo.resolutionWidth * 0.35,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: ManageDeviceInfo.resolutionHeight * 0.024,
                            ),
                            Container(
                              margin: EdgeInsets.only(left:ManageDeviceInfo.resolutionWidth * 0.05),
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: ManageDeviceInfo.resolutionWidth * 0.45,
                                height: ManageDeviceInfo.resolutionHeight * 0.05,
                                child: Text(ModelComicDetailInfo.getInstance().mainTitleName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ManageDeviceInfo.resolutionHeight * 0.024,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: ManageDeviceInfo.resolutionHeight * 0.024,
                            ),
                            Container(
                              
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    ManageDeviceInfo.resolutionWidth * 0.05,
                                    ManageDeviceInfo.resolutionHeight * 0.005,
                                    0,
                                    ManageDeviceInfo.resolutionHeight * 0.01),
                                child: SizedBox(
                                  width: ManageDeviceInfo.resolutionWidth * 0.45,
                                  child: Text(
                                    'Creator: ${ModelComicDetailInfo.getInstance().creatorName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.normal,
                                      fontSize: ManageDeviceInfo.resolutionHeight * 0.020,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Container(
                    height: ManageDeviceInfo.resolutionHeight * 0.08,
                    
                    color: Colors.grey[300],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: ManageDeviceInfo.resolutionHeight * 0.05,
                          width: ManageDeviceInfo.resolutionWidth * 0.9,
                          child: FlatButton(
                            color: Colors.red[300],
                            splashColor: Colors.orangeAccent,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewerScreen(
                                      ModelComicDetailInfo.getInstance().userId,
                                      ModelComicDetailInfo.getInstance().comicId,
                                      ModelPreset.convertCountIndex2EpisodeId(0)),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    CupertinoIcons.book,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: ManageDeviceInfo.resolutionWidth * 0.02,
                                  ),
                                  Text(
                                    '처음부터 보기 ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ManageDeviceInfo.resolutionHeight * 0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              ManageDeviceInfo.resolutionHeight * 0.010,
                              0,
                              ManageDeviceInfo.resolutionHeight * 0.015),
                          child: SizedBox(
                            width: ManageDeviceInfo.resolutionWidth * 0.8,
                            child: Text(
                              ModelComicDetailInfo.getInstance().explain,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.normal,
                                fontSize:
                                    ManageDeviceInfo.resolutionHeight * 0.02,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BuildAlertDialog(null);
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            CupertinoIcons.info,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(top: ManageDeviceInfo.resolutionHeight * 0.00),
                    //              height: ManageDeviceInfo.resolutionHeight * 0.09,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        LikedWidget(),
                        SaveToViewList(),
                        ShareWidget(),
                      ]),
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
                        child: ModelComicDetailInfo.getInstance().modelComicInfoList == null
                            ? Text(
                                'Episodes( 0 )',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      ManageDeviceInfo.resolutionHeight * 0.021,
                                  color: Colors.black87,
                                ),
                              )
                            : Text(
                                'Episodes( ${ModelComicDetailInfo.getInstance().modelComicInfoList.length} )',
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
                  SizedBox(
                    height: ManageDeviceInfo.resolutionHeight * 0.02,
                  ),
                  new EpisodeListViewWidget(c2sComicDetailInfo: c2sComicDetailInfo),
                ],
              ),
      ),
    );
  }
}



