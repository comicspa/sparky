import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/packets/packet_c2s_storage_file_real_url.dart';
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
import 'package:sparky/models/model_localization_info.dart';
import 'package:sparky/packets/packet_c2s_common.dart';
import 'package:sparky/packets/packet_s2c_common.dart';
import 'package:sparky/manage/manage_message.dart';
import 'package:sparky/packets/packet_common.dart';
import 'package:sparky/packets/packet_s2c_storage_file_real_url.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:sparky/packets/packet_c2s_finish_message.dart';


class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => new _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> with WidgetsBindingObserver
{
  //Stream<PacketS2CCommon> _broadcastStream;

  Timer _timer;
  List<PacketC2SCommon> _messageList;

  PacketC2SLibraryRecentComicInfo _packetC2SLibraryRecentComicInfo = new PacketC2SLibraryRecentComicInfo();
  PacketC2SLibraryViewListComicInfo _packetC2SLibraryViewListComicInfo = new PacketC2SLibraryViewListComicInfo();
  PacketC2SLibraryOwnedComicInfo _packetC2SLibraryOwnedComicInfo = new PacketC2SLibraryOwnedComicInfo();
  PacketC2SLibraryContinueComicInfo _packetC2SLibraryContinueComicInfo = new PacketC2SLibraryContinueComicInfo();

  @override
  void initState()
  {
    print('[library : initState]');
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // generating packet

    /*
    _broadcastStream = ManageMessage.streamController.stream;
    _broadcastStream.listen((data)
    {
      print("DataReceived1: " + data.type.toString());

      switch (data.type)
      {
        case e_packet_type.s2c_library_continue_comic_info:
          {
            _packetC2SLibraryOwnedComicInfo.generate();
            ManageMessage.add(_packetC2SLibraryOwnedComicInfo);
          }
          break;

        case e_packet_type.s2c_library_owned_comic_info:
          {
            _packetC2SLibraryRecentComicInfo.generate();
            ManageMessage.add(_packetC2SLibraryRecentComicInfo);
          }
          break;

        case e_packet_type.s2c_library_recent_comic_info:
          {
            _packetC2SLibraryViewListComicInfo.generate();
            ManageMessage.add(_packetC2SLibraryViewListComicInfo);
          }
          break;

        case e_packet_type.s2c_library_view_list_comic_info:
          {
            PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
            packetC2SStorageFileRealUrl.generate(ModelLibraryContinueComicInfo.ModelName);
            ManageMessage.add(packetC2SStorageFileRealUrl);
          }
          break;

        case e_packet_type.s2c_storage_file_real_url:
          {
            PacketS2CStorageFileRealUrl packet = data as PacketS2CStorageFileRealUrl;
            switch(packet.modelName)
            {
              case ModelLibraryContinueComicInfo.ModelName:
                {
                  PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                  packetC2SStorageFileRealUrl.generate(ModelLibraryOwnedComicInfo.ModelName);
                  ManageMessage.add(packetC2SStorageFileRealUrl);
                }
                break;

              case ModelLibraryOwnedComicInfo.ModelName:
                {
                  PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                  packetC2SStorageFileRealUrl.generate(ModelLibraryRecentComicInfo.ModelName);
                  ManageMessage.add(packetC2SStorageFileRealUrl);
                }
                break;

              case ModelLibraryRecentComicInfo.ModelName:
                {
                  PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                  packetC2SStorageFileRealUrl.generate(ModelLibraryViewListComicInfo.ModelName);
                  ManageMessage.add(packetC2SStorageFileRealUrl);
                }
                break;

              case ModelLibraryViewListComicInfo.ModelName:
                {}
                break;

              default:
                break;
            }

            setState(() {

            });
          }
          break;

        default:
          break;
      }
    });
    */


    if(null == _messageList)
      _messageList = new List<PacketC2SCommon>();
    Duration duration = new Duration(milliseconds: 100);
    if(null == _timer)
      _timer = new Timer.periodic(duration, update);

    bool dispatched = false;
    if(false == dispatched)
    {
      if (null == ModelLibraryRecentComicInfo.list)
      {
        print('[library : initState] - null == ModelLibraryRecentComicInfo.list');
        _packetC2SLibraryRecentComicInfo.generate(_onFetchDone);
        //ManageMessage.add(_packetC2SLibraryRecentComicInfo);
        _messageList.add(_packetC2SLibraryRecentComicInfo);

        dispatched = true;
      }
      else
      {
        if (1 == ModelLibraryRecentComicInfo.isEmptyUrl())
        {
          PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
          packetC2SStorageFileRealUrl.generate(ModelLibraryRecentComicInfo.ModelName, onFetchDone: _onFetchDone);
          //ManageMessage.add(packetC2SStorageFileRealUrl);
          _messageList.add(packetC2SStorageFileRealUrl);

          dispatched = true;
        }
      }
    }

    if(false == dispatched)
    {
      if (null == ModelLibraryViewListComicInfo.list)
      {
        print('[library : initState] - null == ModelLibraryViewListComicInfo.list');
        _packetC2SLibraryViewListComicInfo.generate(_onFetchDone);
        //ManageMessage.add(_packetC2SLibraryViewListComicInfo);
        _messageList.add(_packetC2SLibraryViewListComicInfo);

        dispatched = true;
      }
      else
      {
        if (1 == ModelLibraryViewListComicInfo.isEmptyUrl())
        {
          PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
          packetC2SStorageFileRealUrl.generate(ModelLibraryViewListComicInfo.ModelName, onFetchDone: _onFetchDone);
          //ManageMessage.add(packetC2SStorageFileRealUrl);
          _messageList.add(packetC2SStorageFileRealUrl);

          dispatched = true;
        }
      }
    }

    if(false == dispatched)
    {
      if (null == ModelLibraryOwnedComicInfo.list)
      {
        print('[library : initState] - null == ModelLibraryOwnedComicInfo.list');
        _packetC2SLibraryOwnedComicInfo.generate(_onFetchDone);
        //ManageMessage.add(_packetC2SLibraryOwnedComicInfo);
        _messageList.add(_packetC2SLibraryOwnedComicInfo);

        dispatched = true;
      }
      else
      {
        if (1 == ModelLibraryOwnedComicInfo.isEmptyUrl())
        {
          PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
          packetC2SStorageFileRealUrl.generate(ModelLibraryOwnedComicInfo.ModelName, onFetchDone: _onFetchDone);
          //ManageMessage.add(packetC2SStorageFileRealUrl);
          _messageList.add(packetC2SStorageFileRealUrl);

          dispatched = true;
        }
      }
    }

    if(false == dispatched)
    {
      if (null == ModelLibraryContinueComicInfo.list)
      {
        print('[library : initState] - null == ModelLibraryContinueComicInfo.list');
        _packetC2SLibraryContinueComicInfo.generate(_onFetchDone);
        //ManageMessage.add(_packetC2SLibraryContinueComicInfo);
        _messageList.add(_packetC2SLibraryContinueComicInfo);

        dispatched = true;
      }
      else
      {
        if (1 == ModelLibraryContinueComicInfo.isEmptyUrl())
        {
          PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
          packetC2SStorageFileRealUrl.generate(ModelLibraryContinueComicInfo.ModelName, onFetchDone: _onFetchDone);
          //ManageMessage.add(packetC2SStorageFileRealUrl);
          _messageList.add(packetC2SStorageFileRealUrl);

          dispatched = true;
        }
      }
    }
  }


  void _onFetchDone(PacketCommon packetCommon)
  {
    PacketS2CCommon packetS2CCommon = packetCommon as PacketS2CCommon;
    print('[splash : _onFetchDone] - ${packetS2CCommon.type.toString()}');

    switch (packetS2CCommon.type)
    {

      case e_packet_type.s2c_library_recent_comic_info:
        {
          int isEmptyUrl = ModelLibraryRecentComicInfo.isEmptyUrl();
          if (1 == isEmptyUrl)
          {
            PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
            packetC2SStorageFileRealUrl.generate(ModelLibraryRecentComicInfo.ModelName, onFetchDone: _onFetchDone);

            //ManageMessage.add(packetC2SStorageFileRealUrl);
            _messageList.add(packetC2SStorageFileRealUrl);
          }
          else if (0 == isEmptyUrl)
          {
            _packetC2SLibraryViewListComicInfo.generate(_onFetchDone);

            //ManageMessage.add(_packetC2SLibraryViewListComicInfo);
            _messageList.add(_packetC2SLibraryViewListComicInfo);
          }

        }
        break;

      case e_packet_type.s2c_library_view_list_comic_info:
        {
          int isEmptyUrl = ModelLibraryViewListComicInfo.isEmptyUrl();
          if (1 == isEmptyUrl)
          {
            PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
            packetC2SStorageFileRealUrl.generate(ModelLibraryViewListComicInfo.ModelName, onFetchDone: _onFetchDone);

            //ManageMessage.add(packetC2SStorageFileRealUrl);
            _messageList.add(packetC2SStorageFileRealUrl);
          }
          else if (0 == isEmptyUrl)
          {
            _packetC2SLibraryOwnedComicInfo.generate(_onFetchDone);

            //ManageMessage.add(_packetC2SLibraryOwnedComicInfo);
            _messageList.add(_packetC2SLibraryOwnedComicInfo);
          }
        }
        break;

      case e_packet_type.s2c_library_owned_comic_info:
        {
          int isEmptyUrl = ModelLibraryOwnedComicInfo.isEmptyUrl();
          if (1 == isEmptyUrl)
          {
            PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
            packetC2SStorageFileRealUrl.generate(ModelLibraryOwnedComicInfo.ModelName, onFetchDone: _onFetchDone);

            //ManageMessage.add(packetC2SStorageFileRealUrl);
            _messageList.add(packetC2SStorageFileRealUrl);
          }
          else if (0 == isEmptyUrl)
          {
            _packetC2SLibraryContinueComicInfo.generate(_onFetchDone);

            //ManageMessage.add(_packetC2SLibraryContinueComicInfo);
            _messageList.add(_packetC2SLibraryContinueComicInfo);
          }

        }
        break;

      case e_packet_type.s2c_library_continue_comic_info:
        {

          int isEmptyUrl = ModelLibraryContinueComicInfo.isEmptyUrl();
          if (1 == isEmptyUrl)
          {
            PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
            packetC2SStorageFileRealUrl.generate(ModelLibraryContinueComicInfo.ModelName, onFetchDone: _onFetchDone);

            //ManageMessage.add(packetC2SStorageFileRealUrl);
            _messageList.add(packetC2SStorageFileRealUrl);
          }
          else if (0 == isEmptyUrl)
          {
           print('----------------------------------------');
          }

        }
        break;


      case e_packet_type.s2c_storage_file_real_url:
        {
          PacketS2CStorageFileRealUrl packet = packetS2CCommon as PacketS2CStorageFileRealUrl;
          switch(packet.modelName)
          {
            case ModelLibraryRecentComicInfo.ModelName:
              {
                if(null == ModelLibraryViewListComicInfo.list)
                {
                  _packetC2SLibraryViewListComicInfo.generate(_onFetchDone);

                  //ManageMessage.add(_packetC2SLibraryViewListComicInfo);
                  _messageList.add(_packetC2SLibraryViewListComicInfo);
                }
                else
                {
                  if(1 == ModelLibraryViewListComicInfo.isEmptyUrl())
                  {
                    PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                    packetC2SStorageFileRealUrl.generate(ModelLibraryViewListComicInfo.ModelName,onFetchDone: _onFetchDone);

                    //ManageMessage.add(packetC2SStorageFileRealUrl);
                    _messageList.add(packetC2SStorageFileRealUrl);
                  }
                }
              }
              break;

            case ModelLibraryViewListComicInfo.ModelName:
              {
                if(null == ModelLibraryOwnedComicInfo.list)
                {
                  _packetC2SLibraryOwnedComicInfo.generate(_onFetchDone);

                  //ManageMessage.add(_packetC2SLibraryOwnedComicInfo);
                  _messageList.add(_packetC2SLibraryOwnedComicInfo);
                }
                else
                {
                  if(1 == ModelLibraryOwnedComicInfo.isEmptyUrl())
                  {
                    PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                    packetC2SStorageFileRealUrl.generate(ModelLibraryOwnedComicInfo.ModelName,onFetchDone: _onFetchDone);

                    //ManageMessage.add(packetC2SStorageFileRealUrl);
                    _messageList.add(packetC2SStorageFileRealUrl);
                  }
                }
              }
              break;


            case ModelLibraryOwnedComicInfo.ModelName:
              {
                if(null == ModelLibraryContinueComicInfo.list)
                {
                  _packetC2SLibraryContinueComicInfo.generate(_onFetchDone);

                  //ManageMessage.add(_packetC2SLibraryContinueComicInfo);
                  _messageList.add(_packetC2SLibraryContinueComicInfo);
                }
                else
                {
                  if(1 == ModelLibraryContinueComicInfo.isEmptyUrl())
                  {
                    PacketC2SStorageFileRealUrl packetC2SStorageFileRealUrl = new PacketC2SStorageFileRealUrl();
                    packetC2SStorageFileRealUrl.generate(ModelLibraryContinueComicInfo.ModelName,onFetchDone: _onFetchDone);

                    //ManageMessage.add(packetC2SStorageFileRealUrl);
                    _messageList.add(packetC2SStorageFileRealUrl);
                  }
                }
              }
              break;


            case ModelLibraryContinueComicInfo.ModelName:
              {
               print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

              }
              break;

            default:
              break;
          }
        }
        break;

      default:
        break;
    }

    setState(() {

    });
  }


  void update(Timer timer)
  {
    //print('start current time : ${timer.tick}');
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

          case e_packet_type.c2s_library_recent_comic_info:
            {
              PacketC2SLibraryRecentComicInfo packet = packetC2SCommon as PacketC2SLibraryRecentComicInfo;
              packet.fetch(null);
              _messageList.removeAt(0);
            }
            break;

          case e_packet_type.c2s_library_view_list_comic_info:
            {
              PacketC2SLibraryViewListComicInfo packet = packetC2SCommon as PacketC2SLibraryViewListComicInfo;
              packet.fetch(null);
              _messageList.removeAt(0);
            }
            break;

          case e_packet_type.c2s_library_owned_comic_info:
            {
              PacketC2SLibraryOwnedComicInfo packet = packetC2SCommon as PacketC2SLibraryOwnedComicInfo;
              packet.fetch(null);
              _messageList.removeAt(0);
            }
            break;

          case e_packet_type.c2s_library_continue_comic_info:
            {
              PacketC2SLibraryContinueComicInfo packet = packetC2SCommon as PacketC2SLibraryContinueComicInfo;
              packet.fetch(null);
              _messageList.removeAt(0);
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

    print('[library : dispose]');

    PacketC2SFinishMessage packet = new PacketC2SFinishMessage();
    _messageList.add(packet);

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
                child: _packetC2SLibraryRecentComicInfo.fetch(null) == null
                    ? Center(child: LoadingIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ManageDeviceInfo.resolutionHeight *
                                      0.04)),
                          FutureBuilder<List<ModelLibraryRecentComicInfo>>(
                            future: _packetC2SLibraryRecentComicInfo.fetch(null),
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
                child: _packetC2SLibraryViewListComicInfo.fetch(null) == null
                    ? Center(child: LoadingIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ManageDeviceInfo.resolutionHeight *
                                      0.04)),
                          FutureBuilder<List<ModelLibraryViewListComicInfo>>(
                            future: _packetC2SLibraryViewListComicInfo.fetch(null),
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
                child: _packetC2SLibraryOwnedComicInfo.fetch(null) == null
                    ? Center(child: LoadingIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ManageDeviceInfo.resolutionHeight *
                                      0.04)),
                          FutureBuilder<List<ModelLibraryOwnedComicInfo>>(
                            future: _packetC2SLibraryOwnedComicInfo.fetch(null),
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
                child: _packetC2SLibraryContinueComicInfo.fetch(null) == null
                    ? Center(child: LoadingIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: ManageDeviceInfo.resolutionHeight *
                                      0.04)),
                          FutureBuilder<List<ModelLibraryContinueComicInfo>>(
                            future: _packetC2SLibraryContinueComicInfo.fetch(null),
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
      itemCount: values == null? 0 : values.length,
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
                              snapshot.data[index].creatorId,
                              snapshot.data[index]
                                  .comicNumber,snapshot.data[index].partNumber,snapshot.data[index].seasonNumber), // link to Actual viewer
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child:


                      null != snapshot.data[index].url ? FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: snapshot.data[index].url,
                        fit: BoxFit.cover,
                        height: ManageDeviceInfo.resolutionHeight * 0.15,
                      )
                          : Image.asset('images/Comi.png'),

                      /*
                      CachedNetworkImage(
                        imageUrl: snapshot.data[index].url,
                        placeholder: (context, url) => LoadingIndicator(),
                        width: ManageDeviceInfo.resolutionWidth * 0.25,
                        height: ManageDeviceInfo.resolutionWidth * 0.25,
                        fit: BoxFit.fill,
                      ),
                      */

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
                              snapshot.data[index].creatorId,
                              snapshot.data[index]
                                  .comicNumber,snapshot.data[index].partNumber,snapshot.data[index].seasonNumber), // link to Actual viewer
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
                              child: Text(ModelLocalizationInfo.getText('library','text_title')+'${snapshot.data[index].titleName}',
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
                                snapshot.data[index].creatorId,
                                snapshot.data[index]
                                    .comicNumber,snapshot.data[index].partNumber,snapshot.data[index].seasonNumber), // link to Actual viewer
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



