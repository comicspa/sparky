import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';


import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'package:sparky/screens/coming_soon.dart';
import 'package:sparky/screens/common_widgets.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/screens/viewer.dart';
import 'package:sparky/screens/common_widgets.dart';
import 'package:sparky/models/model_preset.dart';



class EpisodeTotalNumberDisplayWidget extends StatelessWidget {
  const EpisodeTotalNumberDisplayWidget({
    Key key,
    this.episodeCount,
  }) : super(key: key);

  final episodeCount;

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
          child: episodeCount == null
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
                  'Episodes( ${episodeCount.length} )',
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
              child: CachedNetworkImage(
                imageUrl: titleThumnailUrl,
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
                    builder: (context) => ComingSoonScreen(),
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
  bool _isLiked = false;
  int _LikeCount = 41;

  void _toggleLike() {
  setState(() {
    if (_isLiked) {
      _LikeCount -= 1;
      _isLiked = false;
    } else {
      _LikeCount += 1;
      _isLiked = true;
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
              icon: (_isLiked ? Icon(Icons.star) : Icon(Icons.star_border)),
              color: Colors.red[500],
              onPressed: _toggleLike,
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