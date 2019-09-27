import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'viewer.dart';

import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'common_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:sparky/packets/packet_s2c_common.dart';

class DetailPage extends StatefulWidget {
  final String _userId;
  final String _comicId;
  DetailPage(this._userId, this._comicId);
  bool _favorited = true;
  

  @override
  _DetailPageState createState() => _DetailPageState(_userId, _comicId);
}

class _DetailPageState extends State<DetailPage> with WidgetsBindingObserver {
  final String _userId;
  final String _comicId;
  bool _favorited = true;
  int _favoriteCount = 41;


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
        child: ModelComicDetailInfo.getInstance().representationImageUrl == null
            ? LoadingIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: ManageDeviceInfo.resolutionHeight * 0.02,
                  ),
                  Container(
                    
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          ManageDeviceInfo.resolutionHeight * 0.0,
                          0,
                          ManageDeviceInfo.resolutionHeight * 0.01),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: CachedNetworkImage(
                          imageUrl: ModelComicDetailInfo.getInstance().representationImageUrl,
                          width: ManageDeviceInfo.resolutionWidth * 0.375,
                          height: ManageDeviceInfo.resolutionWidth * 0.375,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          ManageDeviceInfo.resolutionHeight * 0.004,
                          0,
                          ManageDeviceInfo.resolutionHeight * 0.002),
                      child: SizedBox(
                        width: ManageDeviceInfo.resolutionWidth * 0.6,
                        child: Text(
                          ModelComicDetailInfo.getInstance().mainTitleName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            fontSize: ManageDeviceInfo.resolutionHeight * 0.024,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          0,
                          ManageDeviceInfo.resolutionHeight * 0.005,
                          0,
                          ManageDeviceInfo.resolutionHeight * 0.01),
                      child: SizedBox(
                        width: ManageDeviceInfo.resolutionWidth * 0.6,
                        child: Text(
                          'By: ${ModelComicDetailInfo.getInstance().creatorName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            fontSize: ManageDeviceInfo.resolutionHeight * 0.020,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
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
                        FavoriteWidget(),
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

class EpisodeListViewWidget extends StatelessWidget {
  const EpisodeListViewWidget({
    Key key,
    @required this.c2sComicDetailInfo,
  }) : super(key: key);

  final PacketC2SComicDetailInfo c2sComicDetailInfo;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ModelComicDetailInfo>(
      future: c2sComicDetailInfo.fetch(null),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: ManageDeviceInfo.resolutionHeight * .25,
                  child: Center(child: LoadingIndicator()),
                ),
              ],
            ),
          );
        {
          return buildEpisodeListView();
        }
      },
    );
  }

  ListView buildEpisodeListView() {
    return ListView.separated(
          separatorBuilder: (BuildContext context, index) =>
              Divider(
            height: ManageDeviceInfo.resolutionHeight * 0.004,
          ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: ModelComicDetailInfo.getInstance().modelComicInfoList.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(

                  padding: EdgeInsets.all(ManageDeviceInfo.resolutionWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 4,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                  ViewerScreen(ModelComicDetailInfo.getInstance().userId,
                                  ModelComicDetailInfo.getInstance().comicId,
                                  ModelPreset.convertCountIndex2EpisodeId(index),
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(4.0),
                            child: CachedNetworkImage(
                              imageUrl: ModelComicDetailInfo.getInstance().modelComicInfoList[index].thumbnailImageUrl,
                              placeholder: (context, url) => LoadingIndicator(),
                              width: ManageDeviceInfo.resolutionWidth * 0.26,
                              height: ManageDeviceInfo.resolutionHeight * 0.16,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 7,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewerScreen(ModelComicDetailInfo.getInstance().userId,
                                  ModelComicDetailInfo.getInstance().comicId,
                                  ModelPreset.convertCountIndex2EpisodeId(index),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: SizedBox(
                              width: ManageDeviceInfo.resolutionWidth * 0.5,
                              height: ManageDeviceInfo.resolutionHeight * 0.16,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    alignment:
                                        Alignment.bottomLeft,
                                    padding: EdgeInsets.only(
                                        left: ManageDeviceInfo.resolutionWidth * 0.04),
                                    child: Text(
                                        '${ModelComicDetailInfo.getInstance().modelComicInfoList[index].episode}화',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.normal,
                                          fontSize: ManageDeviceInfo.resolutionHeight * 0.025,
                                          color: Colors.black87,
                                        )),
                                  ),
                                  Container(
                                    alignment:
                                        Alignment.bottomLeft,
                                    padding: EdgeInsets.only(
                                        left: ManageDeviceInfo.resolutionWidth * 0.04),
                                    child: Text(
                                        '${ModelComicDetailInfo.getInstance().modelComicInfoList[index].subTitleName}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.normal,
                                          fontSize: ManageDeviceInfo.resolutionHeight * 0.02,
                                          color: Colors.black87,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.timer,
                              color: Colors.black87
                            ),
                          onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (BuildContext context) {
                                  return BuildAlertDialog(null);
                                },
                              );
                            },
                          ),
                        )
                      ),
                      Flexible(
                        flex: 2,
                        child: Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.file_download,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder:
                                    (BuildContext context) {
                                  return BuildAlertDialog(null);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
  }
}

class FavoriteWidget extends StatefulWidget {
  
  FavoriteWidget({Key key}) : super(key: key);
  
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  int _favoriteCount = 41;

  void _toggleFavorite() {
  setState(() {
    if (_isFavorited) {
      _favoriteCount -= 1;
      _isFavorited = false;
    } else {
      _favoriteCount += 1;
      _isFavorited = true;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(          
          padding: EdgeInsets.all(0),
          alignment: Alignment.center,
            child: IconButton(
              icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
              color: Colors.red[500],
              onPressed: _toggleFavorite,
            ),
        ),
        SizedBox(width: ManageDeviceInfo.resolutionWidth * 0.015,),
        Container(
          alignment: Alignment.center,
          child: Text(
            '좋아요',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: ManageDeviceInfo.resolutionHeight * 0.017,
              color: Colors.black87,
            ),
          ),
        )
      ],
    );
  }

}


class SaveToViewList extends StatefulWidget {
  
  SaveToViewList({Key key}) : super(key: key);

  _SaveToViewListState createState() => _SaveToViewListState();
}

class _SaveToViewListState extends State<SaveToViewList> {
  bool _saveToViewList = false;
  int _saveToViewListCount = 0;
  

  void _toggleSaveToViewList() {
  setState(() {
    if (_saveToViewList) {
      _saveToViewListCount -= -1;
      _saveToViewList = false;
    } else {
      _saveToViewListCount += 1;
      _saveToViewList = true;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(          
          padding: EdgeInsets.all(0),
          alignment: Alignment.center,
            child: IconButton(
              icon: (_saveToViewList ? Icon(CupertinoIcons.add) : Icon(CupertinoIcons.add_circled,)),
              color: Colors.red[500],
              onPressed: _toggleSaveToViewList,
            ),
        ),
        SizedBox(width: ManageDeviceInfo.resolutionWidth * 0.015,),
        Container(
          alignment: Alignment.center,
          child: Text(
            '나중에 보기',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize: ManageDeviceInfo.resolutionHeight * 0.017,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

}


class ShareWidget extends StatefulWidget {
  ShareWidget({Key key}) : super(key: key);

  _ShareWidgetState createState() => _ShareWidgetState();
}

class _ShareWidgetState extends State<ShareWidget> {
  bool _shareClicked = false;
  int _sharedCount = 0;
  

  void _toggleShared() {
    setState(() {
      if (_shareClicked) {
        _shareClicked = false;
      } else {
        _sharedCount += 1;
        _shareClicked = true;
        Share.share('check out my website https://superants.io');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(          
          padding: EdgeInsets.all(0),
          alignment: Alignment.center,
            child: IconButton(
              icon: _shareClicked ? Icon(CupertinoIcons.share_solid) : Icon(CupertinoIcons.share_up),
              color: Colors.deepOrangeAccent,
              onPressed: _toggleShared,
            ),
        ),
        SizedBox(
          width:
              ManageDeviceInfo.resolutionWidth * 0.015,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            '공유하기',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
              fontSize:
                  ManageDeviceInfo.resolutionHeight *
                      0.017,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}