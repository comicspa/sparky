import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';
// import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/manage/manage_toast_message.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_subscribe_comic.dart';
import 'package:sparky/screens/page_prepare_service.dart';
import 'package:sparky/screens/common_widgets.dart';

import 'package:sparky/screens/viewer.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/models/model_preset.dart';
import 'package:transparent_image/transparent_image.dart';



class EpisodeTotalNumberDisplayWidget extends StatelessWidget {
  const EpisodeTotalNumberDisplayWidget({
    Key key,
    this.episodeCount,
  }) : super(key: key);

  final int episodeCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            ManageDeviceInfo.resolutionWidth * 0.02,
            0.0,
            0.0,
            0.0),
        child: SizedBox(
          width: ManageDeviceInfo.resolutionWidth * 0.8,
          child: episodeCount == 0
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
                  'Episodes( $episodeCount )',
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
    );
  }
}

class StorylineTextBoxWidget extends StatelessWidget {
  const StorylineTextBoxWidget({
    Key key,
    this.storyText,
  }) : super(key: key);

  final String storyText;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              child: Text(storyText,
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
    );
  }
}


class ViewFrom1stEpisodeWidget extends StatelessWidget {
  

  const ViewFrom1stEpisodeWidget({
    Key key,
    this.userId,
    this.comicId,
    this.firstEpisodeId,
  }) : super(key: key);

  final userId;
  final comicId;
  final firstEpisodeId;


  @override
  Widget build(BuildContext context) {
    return Container(
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
                      userId,
                      comicId,
                      firstEpisodeId,
                    )
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
    );
  }
}

class DeatilHeaderTitleWidget extends StatelessWidget {
  const DeatilHeaderTitleWidget({
    Key key,
    this.titleThumnailUrl,
    this.titleName,
    this.creatorName,  
  }) : super(key: key);

  final String titleThumnailUrl;
  final String titleName;
  final String creatorName;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: titleThumnailUrl,
                width: ManageDeviceInfo.resolutionWidth * 0.35,
                height: ManageDeviceInfo.resolutionWidth * 0.35,
                fit: BoxFit.fill,
              )
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
                  child: Text(titleName,
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
                      'Creator: $creatorName',
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
    );
  }
}




class StoryTranslationIconWidget extends StatelessWidget {
  const StoryTranslationIconWidget({
    Key key,
    this.iconText, 
    
    }) : super(key: key);

  final String iconText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(          
          padding: EdgeInsets.all(0),
          alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.translate),
              color: Colors.red[500],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PagePrepareService(),
                  ),
                );
              },
            ),
        ),
        SizedBox(width: ManageDeviceInfo.resolutionWidth * 0.015,),
        Container(
          alignment: Alignment.center,
          child: Text(
            iconText,
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


class LikedIconWidget extends StatefulWidget {
  
  LikedIconWidget({Key key,
  
  }) : super(key: key);
  
  @override
  _LikedIconWidgetState createState() => _LikedIconWidgetState();
}

class _LikedIconWidgetState extends State<LikedIconWidget> {

  PacketC2SSubscribeComic _packetC2SSubscribeComic = new PacketC2SSubscribeComic();
  bool _fetchStatus = false;

  void _onFetchDone(PacketS2CCommon packetS2cPacket)
  {
    switch(packetS2cPacket.type)
    {
      case e_packet_type.s2c_subscribe_comic:
        {
          if(1 == ModelComicDetailInfo.getInstance().subscribed)
            {
              ManageToastMessage.showShort('구독 되었습니다.');
            }
          else
            {
              ManageToastMessage.showShort('구독 취소되었습니다.');
            }

        }
        break;

      default:
        break;
    }

    _fetchStatus = false;

    setState(()
    {

    });
  }


  void _toggleSubscribe()
  {
    if(false == ModelUserInfo.getInstance().signedIn)
    {
      ManageToastMessage.showShort('로그인이 필요합니다.');
      return;
    }


    if(true == _fetchStatus)
    {
      ManageToastMessage.showShort('잠시 기다려 주세요.');
      return;
    }
    _fetchStatus = true;

    _packetC2SSubscribeComic.generate(ModelUserInfo.getInstance().uId,
        ModelComicDetailInfo.getInstance().creatorId,
        ModelComicDetailInfo.getInstance().comicNumber,
        ModelComicDetailInfo.getInstance().partNumber,
        ModelComicDetailInfo.getInstance().seasonNumber,
        1 == ModelComicDetailInfo.getInstance().subscribed? 0 : 1);
    _packetC2SSubscribeComic.fetch(_onFetchDone);
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
              icon: (1 == ModelComicDetailInfo.getInstance().subscribed? Icon(Icons.star) : Icon(Icons.star_border)),
              color: Colors.red[500],
              onPressed: _toggleSubscribe,
            ),
        ),
        SizedBox(width: ManageDeviceInfo.resolutionWidth * 0.015,),
        Container(
          alignment: Alignment.center,
          child: Text(
            '구독하기',
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


class SaveToViewListIcon extends StatefulWidget {
  
  SaveToViewListIcon({Key key}) : super(key: key);

  _SaveToViewListIconState createState() => _SaveToViewListIconState();
}

class _SaveToViewListIconState extends State<SaveToViewListIcon> {
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


class ShareIconWidget extends StatefulWidget {
  ShareIconWidget({Key key}) : super(key: key);

  _ShareIconWidgetState createState() => _ShareIconWidgetState();
}

class _ShareIconWidgetState extends State<ShareIconWidget> {
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

class EpisodeListViewWidget extends StatelessWidget {
  EpisodeListViewWidget({
    Key key,
    @required this.c2sComicDetailInfo,
 
  }) : super(key: key);

  final PacketC2SComicDetailInfo c2sComicDetailInfo;
  String comicsOriginalLanguage = 'ko_kr';//String comicsOriginalLanguage = 'en_us';


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
          itemCount: ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList.length,
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
                            if (true == ManageDeviceInfo.equalLanguageLocaleCode(comicsOriginalLanguage))
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => 


                                        /*
                                    switch(ManageDeviceInfo.getLanguageLocaleCode())
                                    {
                                      case 'ko_kr':
                                      {}
                                      break;

                                      case 'en_us':
                                      {}
                                      break;

                                      default:
                                      break;
                                    }*/


                                  ViewerScreen(ModelComicDetailInfo.getInstance().userId,
                                  ModelComicDetailInfo.getInstance().comicNumber,
                                  ModelPreset.convertCountIndex2EpisodeId(index),
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(4.0),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList[index].thumbnailUrl,
                              width: ManageDeviceInfo.resolutionWidth * 0.26,
                              height: ManageDeviceInfo.resolutionHeight * 0.16,
                              fit: BoxFit.fill,
                            )
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
                                  ModelComicDetailInfo.getInstance().comicNumber,
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
                                        '${int.parse(ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList[index].episodeNumber)}화',
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
                                        '${ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList[index].titleName}',
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