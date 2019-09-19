import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'common_widgets.dart';
import 'text_editor.dart';


import 'package:sparky/models/model_view_comic.dart';
import 'package:sparky/packets/packet_c2s_view_comic.dart';

import 'package:sparky/models/model_text_detection.dart';


class ViewerScreen extends StatefulWidget {
  //final ModelFeaturedComicInfo modelFeaturedComicInfo;
  //final ModelComicDetailInfo modelComicDetailInfo;
  //final String url;
  //ViewerScreen(this.url);
//  ViewerScreen(this.modelFeaturedComicInfo);
  String userId;
  String comicId;
  String episodeId;
  ViewerScreen(this.userId, this.comicId, this.episodeId);

  @override
  _ViewerScreen createState() => new _ViewerScreen(userId, comicId, episodeId);
}

class _ViewerScreen extends State<ViewerScreen> with WidgetsBindingObserver {
//  PacketC2STodayPopularComicInfo c2STodayPopularComicInfo = new PacketC2STodayPopularComicInfo(); // use this to handle data
  String userId;
  String comicId;
  String episodeId;

  _ViewerScreen(this.userId, this.comicId, this.episodeId);

  PacketC2SViewComic c2sViewComic = PacketC2SViewComic();

//  @override
//  void initState() {
//    super.initState();
//    c2STodayPopularComicInfo.generate(0, 0);   // generating packet
//
//  }
  bool _isVisible;

  @override
  initState() {
    //    SystemChrome.setEnabledSystemUIOverlays([]);

    c2sViewComic.generate(this.userId, this.comicId, this.episodeId);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _isVisible = true;
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

//  String url;
  // ModelFeaturedComicInfo modelFeaturedComicInfo;

  /*
  _ViewerScreen(ModelFeaturedComicInfo modelFeaturedComicInfo) {
    this.modelFeaturedComicInfo = modelFeaturedComicInfo;
//    this.url = url;
  }
   */

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

              title: Text('Episode #',
                  style: TextStyle(
                      color: Colors.black) //Todo need to bind the data
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
        child: FutureBuilder<List<ModelViewComic>>(
          future: c2sViewComic.fetchBytes(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
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
            {
//                return ListView(
//                  shrinkWrap: true,
//                  scrollDirection: Axis.vertical,
//                  padding: EdgeInsets.all(0.0),
//                  children: List.generate(
//                      ModelViewComic.getInstance().comicImageUrlList.length,
//                      (index) {
//                    return Center(
//                      child: Image.network(ModelViewComic.getInstance()
//                          .comicImageUrlList[index]),
//                    );
//                  }),
//                );
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
              //Todo use pageview.builder to view horizontal style image like 만화 (참고: https://medium.com/flutter-community/a-deep-dive-into-pageview-in-flutter-with-custom-transitions-581d9ea6dded)
            }
          },
        ),
      ),
      /*bottomNavigationBar: Visibility(
        visible: _isVisible,
        child: SizedBox(
          height: ManageDeviceInfo.resolutionHeight * 0.055,
          child: Container(
            color: Colors.blue.withOpacity(0.3),
          )
        ),
      ),*/
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          
          children: <Widget>[
            SizedBox(
              width: ManageDeviceInfo.resolutionWidth * 0.3,
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
