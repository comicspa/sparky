import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/screens/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparky/screens/detail/detail_page.dart';
import 'package:sparky/manage/manage_device_info.dart'; // usegirt this to make all the widget size responsive to the device size.
import 'package:sparky/models/model_library_recent_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_recent_comic_info.dart';
import 'package:sparky/models/model_library_view_list_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_view_list_comic_info.dart';
import 'package:sparky/models/model_library_owned_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_owned_comic_info.dart';
import 'package:sparky/models/model_library_continue_comic_info.dart';
import 'package:sparky/packets/packet_c2s_library_continue_comic_info.dart';
import 'package:sparky/packets/packet_c2s_recommended_comic_info.dart';
import 'package:sparky/models/model_localization_info.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => new _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with WidgetsBindingObserver {
  PacketC2SLibraryRecentComicInfo c2sLibraryRecentComicInfo =
      new PacketC2SLibraryRecentComicInfo();
  PacketC2SLibraryViewListComicInfo c2sMyLibraryViewListComicInfo =
      new PacketC2SLibraryViewListComicInfo();
  PacketC2SLibraryOwnedComicInfo c2sLibraryOwnedComicInfo =
      new PacketC2SLibraryOwnedComicInfo();
  PacketC2SLibraryContinueComicInfo c2sLibraryContinueComicInfo =
      new PacketC2SLibraryContinueComicInfo();
  PacketC2SRecommendedComicInfo c2sRecommendedComicInfo =
      new PacketC2SRecommendedComicInfo();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // generating packet

    //c2sLibraryRecentComicInfo.generate();
    //c2sMyLibraryViewListComicInfo.generate();
    //c2sLibraryOwnedComicInfo.generate();
    //c2sLibraryContinueComicInfo.generate();
    //c2sRecommendedComicInfo.generate(0, 0);
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabBar(
            labelColor: Colors.black,
            //Color(0xFF5986E1),
            labelStyle:
                TextStyle(fontSize: ManageDeviceInfo.resolutionWidth * 0.034, fontWeight: FontWeight.bold),
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.redAccent,
            tabs: [
              Tab(text: ModelLocalizationInfo.getText('library','tab_recent')),
              Tab(text: ModelLocalizationInfo.getText('library','tab_viewList')),
              Tab(text: ModelLocalizationInfo.getText('library','tab_owned')),
              Tab(text: ModelLocalizationInfo.getText('library','tab_downloaded'))
            ]
          ),
          
        ),
          //TODO login needed
        body: 
            
            TabBarView(children: [
              SingleChildScrollView(
                child: c2sLibraryRecentComicInfo.fetch(null) == null
                    ? Center(child: LoadingIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ManageDeviceInfo.resolutionHeight *
                                      0.04)),
                          FutureBuilder<List<ModelLibraryRecentComicInfo>>(
                            future: c2sLibraryRecentComicInfo.fetch(null),
                            builder: (BuildContext context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return LoadingIndicator();
                                case ConnectionState.active:
                                  return LoadingIndicator();
                                case ConnectionState.waiting:
                                  return LoadingIndicator();
                                //
                                case ConnectionState.done:
                                  //default:
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  else
                                    return LibraryListTile(snapshot: snapshot);
                              }

                              return Text('Result: ${snapshot.data}');
                            },
                          ),
                        ],
                      ),
              ),
              SingleChildScrollView(
                child: c2sMyLibraryViewListComicInfo.fetch(null) == null
                    ? Center(child: LoadingIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ManageDeviceInfo.resolutionHeight *
                                      0.04)),
                          FutureBuilder<List<ModelLibraryViewListComicInfo>>(
                            future: c2sMyLibraryViewListComicInfo.fetch(null),
                            builder: (BuildContext context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return LoadingIndicator();
                                case ConnectionState.active:
                                  return LoadingIndicator();
                                case ConnectionState.waiting:
                                  return LoadingIndicator();
                                //
                                case ConnectionState.done:
                                  //default:
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  else
                                    return LibraryListTile(snapshot: snapshot);
                              }

                              return Text('Result: ${snapshot.data}');
                            },
                          ),
                        ],
                      ),
              ),
              SingleChildScrollView(
                child: c2sLibraryOwnedComicInfo.fetch(null) == null
                    ? Center(child: LoadingIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ManageDeviceInfo.resolutionHeight *
                                      0.04)),
                          FutureBuilder<List<ModelLibraryOwnedComicInfo>>(
                            future: c2sLibraryOwnedComicInfo.fetch(null),
                            builder: (BuildContext context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return LoadingIndicator();
                                case ConnectionState.active:
                                  return LoadingIndicator();
                                case ConnectionState.waiting:
                                  return LoadingIndicator();
                                //
                                case ConnectionState.done:
                                  //default:
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  else
                                    return LibraryListTile(snapshot: snapshot);
                              }

                              return Text('Result: ${snapshot.data}');
                            },
                          ),
                        ],
                      ),
              ),
              SingleChildScrollView(
                child: c2sLibraryContinueComicInfo.fetch(null) == null
                    ? Center(child: LoadingIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ManageDeviceInfo.resolutionHeight *
                                      0.04)),
                          FutureBuilder<List<ModelLibraryContinueComicInfo>>(
                            future: c2sLibraryContinueComicInfo.fetch(null),
                            builder: (BuildContext context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                  return LoadingIndicator();
                                case ConnectionState.active:
                                  return LoadingIndicator();
                                case ConnectionState.waiting:
                                  return LoadingIndicator();
                                //
                                case ConnectionState.done:
                                  //default:
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  else
                                    return new LibraryListTile(
                                        snapshot: snapshot);
                              }

                              return Text('Result: ${snapshot.data}');
                            },
                          ),
                        ],
                      ),
              ),
            ])
          
        ),
      
    );
  }
}

class LibraryListTile extends StatelessWidget {
  const LibraryListTile({
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
      scrollDirection: Axis.vertical,
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(left: ManageDeviceInfo.resolutionWidth * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push<Widget>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                              snapshot.data[index].userId,
                              snapshot.data[index]
                                  .comicId), // link to Actual viewer
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data[index].url,
                        placeholder: (context, url) => LoadingIndicator(),
                        width: ManageDeviceInfo.resolutionWidth * 0.25,
                        height: ManageDeviceInfo.resolutionWidth * 0.25,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push<Widget>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                              snapshot.data[index].userId,
                              snapshot.data[index]
                                  .comicId), // link to Actual viewer
                        ),
                      );
                    },
                    child: Container(
                        color: Colors
                            .transparent, // need this to detect gesture on space
                        height: ManageDeviceInfo.resolutionWidth * 0.25,
                        width: ManageDeviceInfo.resolutionWidth * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.only(
                                  left:
                                      ManageDeviceInfo.resolutionWidth * 0.04),
                              child: Text(ModelLocalizationInfo.getText('library','text_title')+'${snapshot.data[index].title}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.normal,
                                    fontSize:
                                        ManageDeviceInfo.resolutionHeight *
                                            0.018,
                                    color: Colors.black87,
                                  )),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.only(
                                  left:
                                      ManageDeviceInfo.resolutionWidth * 0.04),
                              child:
                                  Text(ModelLocalizationInfo.getText('library','text_creator')+':  '+'${snapshot.data[index].creatorName}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontWeight: FontWeight.normal,
                                        fontSize:
                                            ManageDeviceInfo.resolutionHeight *
                                                0.018,
                                        color: Colors.black87,
                                      )),
                            ),
                          ],
                        )),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    child: IconButton(
                      icon: ImageIcon(
                        AssetImage(
                          'images/Chevron Right.png',
                        ),
                      ),
                      color: Colors.black54,
                      iconSize: ManageDeviceInfo.resolutionHeight * 0.03,
                      onPressed: () {
                        Navigator.push<Widget>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                                snapshot.data[index].userId,
                                snapshot.data[index]
                                    .comicId), // link to Actual viewer
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}



