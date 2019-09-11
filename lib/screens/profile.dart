import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'viewer.dart';
import 'coming_soon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'common_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/models/model_preset.dart';
import 'dart:math';


class ProfileScreen extends StatefulWidget {
  final String _userId;
  final String _comicId;
  ProfileScreen(this._userId, this._comicId);

  @override
  _ProfileScreenState createState() => _ProfileScreenState(_userId, _comicId);
}

class _ProfileScreenState extends State<ProfileScreen> with WidgetsBindingObserver {
  final String _userId;
  final String _comicId;

  _ProfileScreenState(this._userId, this._comicId);

  PacketC2SComicDetailInfo c2sComicDetailInfo = new PacketC2SComicDetailInfo();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    // generating packet

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
    await c2sComicDetailInfo.fetchBytes();
    setState(() {});
  }


  // final Profile profile;

  // ProfileHeader(this.profile);

  @override
  Widget build(BuildContext context) {
    // final topPadding = MediaQuery
    //     .of(context)
    //     .padding
    //     .top;

    // final headerGradient = new RadialGradient(
    //   center: Alignment.topLeft,
    //   radius: 0.4,
    //   colors: <Color>[
    //     const Color(0xFF8860EB),
    //     const Color(0xFF8881EB),
    //   ],
    //   stops: <double>[
    //     0.4, 1.0,
    //   ],
    //   tileMode: TileMode.repeated,
    // );


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
            centerTitle: true,

            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                width: ManageDeviceInfo.resolutionWidth * 0.7,
                child: ModelComicDetailInfo.getInstance().mainTitleName == null
                    ? Text(
                        'Loading...',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
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
                        textAlign: TextAlign.center,
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
    body: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          new ProfileHeader(), //Todo Need to pass Profile data here
          new QuickActions(),
          new MainMenu(),
        ],
      ),
    );
  }

  /// Build the bell icon at the top right corner of the header
  Widget _buildBellIcon() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.notifications_none, color: Colors.white, size: 30.0,),
            onPressed: () {}),
      ],
    );
  }

  Widget _buildTitle() {
    return new Text("Profile",
        style: new TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 40.0,
            letterSpacing: 1.0));
  }

  /// The avatar consists of the profile image, the users name and location
  Widget _buildAvatar() {
    final mainTextStyle = new TextStyle(fontFamily: 'Lato',
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 20.0);
    final subTextStyle = new TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        color: Colors.white70,
        fontWeight: FontWeight.w700);

    return new Row(
      children: <Widget>[
        new Container(
          width: 70.0, height: 60.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/images/emma-watson.jpg"),
                fit: BoxFit.cover),
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                  color: Colors.black26, blurRadius: 5.0, spreadRadius: 1.0),
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.only(right: 20.0)),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('My Name', style: mainTextStyle),
            new Text('Location', style: subTextStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildFollowerStats() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildFollowerStat("Followers", '20 K'),
        _buildVerticalDivider(),
        _buildFollowerStat("Following", '432'),
        _buildVerticalDivider(),
        _buildFollowerStat("Total Likes", '13 K'),
      ],
    );
  }

  Widget _buildFollowerStat(String title, String value) {
    final titleStyle = new TextStyle(
        fontSize: 16.0,
        fontFamily: 'Lato',
        color: Colors.white);
    final valueStyle = new TextStyle(
        fontFamily: 'Lato',
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white);
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(title, style: titleStyle),
        new Text(value, style: valueStyle),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return new Container(
      height: 30.0,
      width: 1.0,
      color: Colors.white30,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}


class MainMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
      constraints: const BoxConstraints(maxHeight: 240.0),
      child: new ListView(
        padding: const EdgeInsets.only(left: 5.0),
        children: <Widget>[
          _buildListItem("Memories", Icons.camera, () {}),
          _buildListItem("Favourites", Icons.favorite, () {}),
          _buildListItem("Presents", Icons.card_giftcard, () {}),
          _buildListItem("Friends", Icons.people, () {}),
          _buildListItem("Achievement", Icons.stars, () {}),
        ],
      ),
    );
  }

  Widget _buildListItem(String title, IconData iconData, VoidCallback action) {
    final textStyle = new TextStyle(
        color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.w600);

    return new InkWell(
      onTap: action,
      child: new Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 35.0,
              height: 35.0,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: new BoxDecoration(
                color: Colors.purple,
                borderRadius: new BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: new Icon(iconData, color: Colors.white, size: 24.0),
            ),
            new Text(title, style: textStyle),
            new Expanded(child: new Container()),
            new IconButton(
                icon: new Icon(Icons.chevron_right, color: Colors.black26),
                onPressed: action)
          ],
        ),
      ),
    );
  }

}


class QuickActions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final blueGradient = const LinearGradient(
        colors: const <Color>[
          const Color(0xFF0075D1),
          const Color(0xFF00A2E3),
        ],
        stops: const <double>[0.4, 0.6],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft);
    final purpleGraient = const LinearGradient(
        colors: const <Color>[
          const Color(0xFF882DEB),
          const Color(0xFF9A4DFF)
        ],
        stops: const <double>[0.5, 0.7],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight);
    final redGradient = const LinearGradient(
        colors: const <Color>[
          const Color(0xFFBA110E),
          const Color(0xFFCF3110),
        ],
        stops: const <double>[0.6, 0.8],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft);

    return new Container(
      constraints: const BoxConstraints(maxHeight: 120.0),
      margin: const EdgeInsets.only(top: 20.0),
      child: new Align(
        alignment: Alignment.center,
        child: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
                left: 10.0, bottom: 20.0, right: 10.0, top: 10.0),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildAction(
                  "Live\nBroadcast", () {}, Colors.blue, blueGradient,
                  new AssetImage("assets/images/microphone.png")),
              _buildAction(
                  "My\nWallet", () {}, Colors.purple, purpleGraient,
                  new AssetImage("assets/images/wallet.png")),
              _buildAction(
                  "Game\nCenter", () {}, Colors.red, redGradient,
                  new AssetImage("assets/images/joystick.png")),
            ]
        ),
      ),
    );
  }

  Widget _buildAction(String title, VoidCallback action, Color color,
      Gradient gradient, ImageProvider backgroundImage) {
    final textStyle = new TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        fontFamily: 'Lato');

    return new GestureDetector(
      onTap: action,
      child: new Container(
        margin: const EdgeInsets.only(right: 5.0, left: 5.0),
        width: 150.0,
        decoration: new BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(color: Colors.black38,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: new Offset(0.0, 1.0)),
            ],
            gradient: gradient
        ),
        child: new Stack(
          children: <Widget>[
            new Opacity(
              opacity: 0.2,
              child: new Align(
                alignment: Alignment.centerRight,
                child: new Transform.rotate(
                  angle: -3.14 / 4.8,
                  alignment: Alignment.centerRight,
                  child: new ClipPath(
                    clipper: new _BackgroundImageClipper(),
                    child: new Container(
                      padding: const EdgeInsets.only(
                          bottom: 20.0, right: 0.0, left: 60.0),
                      child: new Image(
                        width: 90.0,
                        height: 90.0,
                        image: backgroundImage != null
                            ? backgroundImage
                            : new AssetImage("assets/images/microphone.png"),
                      ),
                    ),
                  ),
                ),
              ),
            ), // END BACKGROUND IMAGE

            new Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: new Text(title, style: textStyle),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

}

  





class ProfileHeader extends StatelessWidget {

  // final Profile profile;

  // ProfileHeader(this.profile);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery
        .of(context)
        .padding
        .top;

    final headerGradient = new RadialGradient(
      center: Alignment.topLeft,
      radius: 0.4,
      colors: <Color>[
        const Color(0xFF8860EB),
        const Color(0xFF8881EB),
      ],
      stops: <double>[
        0.4, 1.0,
      ],
      tileMode: TileMode.repeated,
    );

    const headerHeight = 290.0;

    return new Container(
      height: headerHeight,
      decoration: new BoxDecoration(
        color: Colors.greenAccent,
        boxShadow: <BoxShadow>[
          new BoxShadow(spreadRadius: 2.0,
              blurRadius: 4.0,
              offset: new Offset(0.0, 1.0),
              color: Colors.black38),
        ],
      ),
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // linear gradient
          new Container(
            height: headerHeight,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: <Color>[ //7928D1
                    const Color(0xFF7928D1), const Color(0xFF9A4DFF)],
                  stops: <double>[0.3, 0.5],
                  begin: Alignment.topRight, end: Alignment.bottomLeft
              ),
            ),
          ),
          // radial gradient
          new CustomPaint(
            painter: new HeaderGradientPainter(),
          ),
          new Padding(
            padding: new EdgeInsets.only(
                top: topPadding, left: 15.0, right: 15.0, bottom: 20.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildBellIcon(),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: _buildTitle(),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _buildAvatar(),
                ),
                _buildFollowerStats()
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the bell icon at the top right corner of the header
  Widget _buildBellIcon() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.notifications_none, color: Colors.white, size: 30.0,),
            onPressed: () {}),
      ],
    );
  }

  Widget _buildTitle() {
    return new Text("Profile",
        style: new TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 40.0,
            letterSpacing: 1.0));
  }

  /// The avatar consists of the profile image, the users name and location
  Widget _buildAvatar() {
    final mainTextStyle = new TextStyle(fontFamily: 'Lato',
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 20.0);
    final subTextStyle = new TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        color: Colors.white70,
        fontWeight: FontWeight.w700);

    return new Row(
      children: <Widget>[
        new Container(
          width: 70.0, height: 60.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/images/emma-watson.jpg"),
                fit: BoxFit.cover),
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                  color: Colors.black26, blurRadius: 5.0, spreadRadius: 1.0),
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.only(right: 20.0)),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text('My Name', style: mainTextStyle),
            new Text('My Location', style: subTextStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildFollowerStats() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildFollowerStat("Followers", '14 K'),
        _buildVerticalDivider(),
        _buildFollowerStat("Following", '542'),
        _buildVerticalDivider(),
        _buildFollowerStat("Total Likes", '839'),
      ],
    );
  }

  Widget _buildFollowerStat(String title, String value) {
    final titleStyle = new TextStyle(
        fontSize: 16.0,
        fontFamily: 'Lato',
        color: Colors.white);
    final valueStyle = new TextStyle(
        fontFamily: 'Lato',
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white);
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(title, style: titleStyle),
        new Text(value, style: valueStyle),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return new Container(
      height: 30.0,
      width: 1.0,
      color: Colors.white30,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}

class HeaderGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: paint background radial gradient
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}