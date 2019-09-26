import 'package:flutter/material.dart';
import 'package:sparky/models/model_weekly_creator_info.dart';
import 'package:sparky/packets/packet_c2s_weekly_creator_info.dart';
import 'package:sparky/models/model_new_creator_info.dart';
import 'package:sparky/packets/packet_c2s_new_creator_info.dart';
import 'more.dart';
import 'creator_detail_page.dart';
import 'common_widgets.dart';

class CreatorScreen extends StatefulWidget {
  @override
  _CreatorScreenState createState() => new _CreatorScreenState();
}

class _CreatorScreenState extends State<CreatorScreen> with WidgetsBindingObserver
{
  PacketC2SWeeklyCreatorInfo c2sWeeklyCreatorInfo =
      new PacketC2SWeeklyCreatorInfo();
  PacketC2SWeeklyCreatorInfo c2sWeeklyCreatorInfo2 =
      new PacketC2SWeeklyCreatorInfo();
  PacketC2SNewCreatorInfo c2sNewCreatorInfo = new PacketC2SNewCreatorInfo(); //

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // generating packet

    c2sWeeklyCreatorInfo.generate();
    c2sWeeklyCreatorInfo2.generate();
    c2sNewCreatorInfo.generate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)
  {
    print('state = $state');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<ModelWeeklyCreatorInfo>>(
                future: c2sWeeklyCreatorInfo.fetch(null),
                builder: (BuildContext context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('');
                    case ConnectionState.active:
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    case ConnectionState.waiting:
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    //
                    case ConnectionState.done:
                      //default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 230.0,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                //TODO need an actual device testing to fix or change the physics type
                                scrollDirection: Axis.horizontal,
                                itemCount: ModelWeeklyCreatorInfo.list.length,
                                itemBuilder: (context, index) {
                                  EdgeInsets padding = index ==
                                          0 // First Card indenting is Left 20 and others are Left 10
                                      ? EdgeInsets.only(
                                          left: 20.0,
                                          right: 10.0,
                                          top: 20.0,
                                          bottom: 20.0)
                                      : EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 20.0,
                                          bottom: 20.0);

                                  return Padding(
                                    padding:
                                        padding, // using padding setting above
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push<Widget>(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CreatorDetailPage(snapshot
                                                    .data[index]
                                                    .url), // link to Actual viewer
                                          ),
                                        );

                                        print(
                                            'Card selected'); //Todo complete onTap:() feature
                                      },
                                      child: Container(
                                        width: 300.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.blueGrey,
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Colors.black.withAlpha(70),
                                                offset: Offset(3.0, 10.0),
                                                blurRadius: 15.0)
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                snapshot.data[index].url),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        //                                    height: 200.0,

                                        child: Stack(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          21, 24, 45, 0.7),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  child: Column(
                                                    // 카드 아래 텍스트 영역
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 300,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                top: 5),
                                                        child: Text(
                                                          '작가: 야옹이', //TODO need $ variable
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 300,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(
                                                          '저 요즘 잘 나가요~!',
                                                          //TODO need $ variable
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                  }

                  return Text('Result: ${snapshot.data}');
                },
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<ModelNewCreatorInfo>>(
                future: c2sNewCreatorInfo.fetch(null),
                builder: (BuildContext context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('');
                    case ConnectionState.active:
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    case ConnectionState.waiting:
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    //
                    case ConnectionState.done:
                      //default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return Column(
                          children: <Widget>[
                            SizedBox(
                              height: 230.0,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                //TODO need an actual device testing to fix or change the physics type
                                scrollDirection: Axis.horizontal,
                                itemCount: ModelNewCreatorInfo.list.length,
                                itemBuilder: (context, index) {
                                  EdgeInsets padding = index ==
                                          0 // First Card indenting is Left 20 and others are Left 10
                                      ? EdgeInsets.only(
                                          left: 20.0,
                                          right: 10.0,
                                          top: 20.0,
                                          bottom: 20.0)
                                      : EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 20.0,
                                          bottom: 20.0);

                                  return Padding(
                                    padding:
                                        padding, // using padding setting above
                                    child: InkWell(
                                      onTap: () {
                                        print(
                                            'Card selected'); //Todo complete onTap:() feature
                                      },
                                      child: Container(
                                        width: 300.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          color: Colors.blueGrey,
                                          boxShadow: [
                                            BoxShadow(
                                                color:
                                                    Colors.black.withAlpha(70),
                                                offset: Offset(3.0, 10.0),
                                                blurRadius: 15.0)
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                snapshot.data[index].url),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        //                                    height: 200.0,

                                        child: Stack(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                  height: 50.0,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          21, 24, 45, 0.7),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  child: Column(
                                                    // 카드 아래 텍스트 영역
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 300,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                top: 5),
                                                        child: Text(
                                                          '작가: 야옹이', //TODO need $ variable
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 300,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(
                                                          '저 요즘 잘 나가요~!',
                                                          //TODO need $ variable
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                  }

                  return Text('Result: ${snapshot.data}');
                },
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: FutureBuilder<List<ModelWeeklyCreatorInfo>>(
                //Todo need to change when Recommended Creator is ready
                future: c2sWeeklyCreatorInfo2.fetch(null),
                builder: (BuildContext context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Text('');
                    case ConnectionState.active:
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    case ConnectionState.waiting:
                      return const Center(
                        child: LoadingIndicator(),
                      );
                    //
                    case ConnectionState.done:
                      //default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                //      itemCount: (present <= widget.hotCreators.length)
                                //          ? widget.hotCreators.length + 1
                                //          : widget.hotCreators.length,
                                itemCount: ModelWeeklyCreatorInfo.list.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreatorDetailPage(snapshot
                                                              .data[index]
                                                              .url))); //Todo testing route so update this later
                                            },
                                          ),
                                        ),
                                      ),
                                      Card(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: SizedBox(
                                            height: 160,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Image.network(
                                                    snapshot.data[index].url,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                //                            AspectRatio(
                                                //                              aspectRatio: 1.0,
                                                //                              child: Container(
                                                //                                decoration: const BoxDecoration(
                                                ////                                image: DecorationImage(
                                                ////                                    image: NetworkImage(
                                                ////                                        snapshot.data[index].picture)
                                                ////                                ),
                                                //                                    color: Colors.pink),
                                                //                              ),
                                                //                            ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        20.0, 0.0, 2.0, 0.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .userId,
                                                                //Todo update this testing data
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              2.0)),
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .explain,
                                                                //Todo update this testing data
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .explain,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              ),
                                                              Text(
                                                                'Date published · views ★', //Todo update this testing data
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                  }

                  return Text('Result: ${snapshot.data}');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
