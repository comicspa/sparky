import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sparky/packets/packet_common.dart';
import 'common_widgets.dart';
import 'text_editor.dart';

import 'package:sparky/models/model_view_comic.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_view_comic.dart';
import 'package:sparky/models/model_comic_info.dart';
import 'package:sparky/models/model_text_detection.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_c2s_finish_message.dart';
import 'package:sparky/packets/packet_c2s_storage_file_real_url.dart';


class ViewerScreen extends StatefulWidget {

  String _userId;
  String _comicId;
  String _episodeId;
  ViewerScreen(this._userId, this._comicId, this._episodeId);

  @override
  _ViewerScreen createState() => new _ViewerScreen(_userId, _comicId, _episodeId);
}

class _ViewerScreen extends State<ViewerScreen> with WidgetsBindingObserver {

  String _userId;
  String _comicId;
  String _episodeId;
  Timer _timer;
  List<PacketC2SCommon> _messageList;

  _ViewerScreen(this._userId, this._comicId, this._episodeId);

  PacketC2SViewComic _c2sViewComic = PacketC2SViewComic();
  bool _isVisible;

  @override
  initState() {

    print('[viewer : initState]');

    //    SystemChrome.setEnabledSystemUIOverlays([]);

    _c2sViewComic.generate(_userId, _comicId, _episodeId);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _isVisible = true;


    if(null == _messageList)
      _messageList = new List<PacketC2SCommon>();
    Duration duration = new Duration(milliseconds: 100);
    if(null == _timer)
      _timer = new Timer.periodic(duration, update);


  }

  void _onFetchDone(PacketCommon packetCommon)
  {
    print('[viewer : _onFetchDone] - type : ${packetCommon.type.toString()}');

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
    //print('update : ${timer.tick}');
    if(null != _messageList)
    {
      if (0 < _messageList.length)
      {
        PacketC2SCommon packetC2SCommon = _messageList[0];

        switch (packetC2SCommon.type)
        {
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


  @override
  void dispose() {

    print('[viewer : dispose]');

    PacketC2SFinishMessage packet = new PacketC2SFinishMessage();
    _messageList.add(packet);

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)
  {
    print('[viewer : didChangeAppLifecycleState] - state :  $state');
  }

  @override
  Widget build(BuildContext context) {
    // Todo Currently this screen is used for testing viewer
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(ManageDeviceInfo.resolutionHeight * 0.055),
        child: Visibility(
          visible: _isVisible,
          child: SafeArea(
            child: AppBar(
              elevation: 1,
              iconTheme: IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white, //Color.fromRGBO(21, 24, 45, 1.0),
              //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
              centerTitle: true,

              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Episode ${int.parse(_episodeId)}',
                      style: TextStyle(
                          color: Colors.black) //Todo need to bind the data
                      ),
                  SizedBox(width: ManageDeviceInfo.resolutionWidth * 0.02,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: null != ModelViewComic.getInstance().viewDirectionType
                          //Todo Need to change Icon with direction
                          ? e_view_direction_type.vertical == ModelViewComic.getInstance().viewDirectionType
                                ? Icon(
                                    Icons.arrow_downward,
                                    size: ManageDeviceInfo.resolutionWidth * 0.04,
                                  )
                                  
                                : Icon(
                                    Icons.arrow_forward,
                                    size: ManageDeviceInfo.resolutionWidth * 0.04
                                  )
                                
                          : null 
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isVisible = !_isVisible;
          });
        },
        child: FutureBuilder<ModelViewComic>(
          future: _c2sViewComic.fetch(_onFetchDone),
          builder: (context, snapshot) {

            if(e_packet_status.finish_dispatch_respond != _c2sViewComic.getRespondStatus())
              {
                //print('e_packet_status.finish_dispatch_respond != _c2sViewComic.getRespondStatus');
                return PercentIndicator();
              }
            else
              {
                //print('e_packet_status.finish_dispatch_respond == _c2sViewComic.getRespondStatus');
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                {
                  if(null != snapshot.data)
                  {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection:
                    snapshot.data.viewDirectionType == e_view_direction_type.vertical
                        ? Axis.vertical
                        : Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.imageUrlList.length,
                    //                      ModelViewComic.getInstance().comicImageUrlList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CachedNetworkImage(
                          imageUrl: snapshot.data.imageUrlList[index],
                        ),
                  );
                  }
                  else
                    return PercentIndicator();
                  }
              }


            /*
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return PercentIndicator();
              case ConnectionState.active:
                return PercentIndicator();
              case ConnectionState.waiting:
                return PercentIndicator();
              //
              case ConnectionState.done:
                //default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection:
                        snapshot.data[0].style == e_comic_view_style.vertical
                            ? Axis.vertical
                            : Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data[0].imageUrlList.length,
    //                      ModelViewComic.getInstance().comicImageUrlList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CachedNetworkImage(
                      imageUrl: snapshot.data[0].imageUrlList[index],
                    ),
                  );
              //Todo use pageview.builder to view horizontal style image like 만화 (참고: https://medium.com/flutter-community/a-deep-dive-into-pageview-in-flutter-with-custom-transitions-581d9ea6dded);
            }
            */


            return Text('Result: ${snapshot.data}');
          },
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: _isVisible,
        child: BottomAppBar(
          color: Colors.transparent,
          child: Container(
            height: ManageDeviceInfo.resolutionHeight * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: ManageDeviceInfo.resolutionHeight * 0.04,
                  width: ManageDeviceInfo.resolutionWidth * 0.26,
                  child: Material(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.all(Radius.circular(60.0)),
                    child: InkWell(
                
                      //Todo Need to apply loading indicator or a Message
                      splashColor: Colors.red[50],
                      onTap: int.parse(_episodeId) == 1
                        ? () {  
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BuildAlertDialog('This episode is the first episode');
                            },
                          );
                        }
                        : () {

                              ModelViewComic.reset();
                              _episodeId =  ModelComicDetailInfo.getInstance().getPrevEpisodeId(_episodeId);
                              _c2sViewComic.generate(_userId, _comicId, _episodeId);
                              _c2sViewComic.fetch(_onFetchDone);

                        },
                      child: Container(
                        
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(60.0)),
                          ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(width: ManageDeviceInfo.resolutionWidth * 0.02,),
                            Icon(Icons.chevron_left, color: Colors.white), 
                            Text('Prev. Ep.',
                              style: TextStyle(
                              color: Colors.white, 
                              ),
                            ),
                          ],
                          
                        ),
                      ),
                    ),
                  ),
                  
                ),
                SizedBox(
                  height: ManageDeviceInfo.resolutionHeight * 0.046,
                  width: ManageDeviceInfo.resolutionWidth * 0.12,
                  child: Material(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    child: InkWell(
                      onTap: (){
                        ModelTextDetection.reset();

                        Navigator.push<Widget>(context,
                          MaterialPageRoute(
                            builder: (context) => DrawRectAndImage(),
                          ));
                      },
                      child: Container(
                        
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(60.0)),
                          ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                           
                            Icon(Icons.translate, color: Colors.white, size: ManageDeviceInfo.resolutionHeight * 0.026), 
                          ],
                          
                        ),
                      ),
                    ),
                  ),
                  
                ),
                SizedBox(
                  height: ManageDeviceInfo.resolutionHeight * 0.04,
                  width: ManageDeviceInfo.resolutionWidth * 0.26,
                  child: Material(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    child: InkWell(
                      onTap: ModelComicDetailInfo.getInstance().modelComicEpisodeInfoList.length == int.parse(_episodeId)
                        ? () {  
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return BuildAlertDialog('Sorry, no more episode for this title');
                            },
                          );
                        }
                        : () {

                              ModelViewComic.reset();
                              _episodeId =  ModelComicDetailInfo.getInstance().getNextEpisodeId(_episodeId);
                              _c2sViewComic.generate(_userId, _comicId,_episodeId);
                              _c2sViewComic.fetch(_onFetchDone);

                        },
                      child: Container(
                        
                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          borderRadius: BorderRadius.all(Radius.circular(60.0)),
                          ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text('Next Ep.',
                              style: TextStyle(
                              color: Colors.white, 
                              ),
                            ),
                            Icon(Icons.chevron_right, color: Colors.white), 
                            SizedBox(width: ManageDeviceInfo.resolutionWidth * 0.02,)
                          ],
                          
                        ),
                      ),
                    ),
                  ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
                  
      /* floatingActionButton: Visibility(
        visible: _isVisible,
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          
          children: <Widget>[
            SizedBox(
              width: ManageDeviceInfo.resolutionWidth * 0.3,
              child: RaisedButton(
                color: Colors.yellowAccent,
              ),
            ),
            Container(
              height: ManageDeviceInfo.resolutionHeight * 0.04,
              width: ManageDeviceInfo.resolutionWidth * 0.24,
              child: FloatingActionButton.extended(
                heroTag: 'btn1',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BuildAlertDialog();
                    },
                  );
                },
                label: Text('Pre Ep.'),
                icon: Icon(Icons.arrow_left),
              ),
            ),
            Container(
              height: ManageDeviceInfo.resolutionHeight * 0.04,
              child: FloatingActionButton(
                heroTag: 'btn2',
                backgroundColor: Colors.redAccent,
                onPressed: () {
                  ModelTextDetection.reset();

                  Navigator.push<Widget>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrawRectAndImage(),
                      ));
                },
                child: Icon(
                  Icons.translate,
                  size: ManageDeviceInfo.resolutionHeight * 0.03,),
              ),
            ),
            Container(
              height: ManageDeviceInfo.resolutionHeight * 0.04,
              width: ManageDeviceInfo.resolutionWidth * 0.24,
              child: FloatingActionButton.extended(
                heroTag: 'btn3',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BuildAlertDialog();
                    },
                  );
                },
                label: Text('Next Ep.'),
                icon: Icon(Icons.arrow_right),
              ),
            ),
          ],
        ),
      ), */
    );
  }
}

class PercentIndicator extends StatelessWidget {
  const PercentIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: ManageDeviceInfo.resolutionHeight * .3,
            child: Center(
              child: CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 4.0,
                animation: true,
                animationDuration: 2700,
                percent: 0.75,
                footer: new Text(
                  "Loading images...",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          ManageDeviceInfo.resolutionHeight * 0.02),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// fade in image loading sample
//
//        Stack(
//          children: <Widget>[
//            Center(child: CircularProgressIndicator()),
//            Center(
//              child: FadeInImage.memoryNetwork(
//                placeholder: kTransparentImage,
//                image: 'https://picsum.photos/250?image=9',
//              ),
//            ),
//          ],
//        )
