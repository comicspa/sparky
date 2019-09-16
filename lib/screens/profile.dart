import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/models/model_comic_detail_info.dart';
import 'package:sparky/packets/packet_c2s_comic_detail_info.dart';
import 'package:sparky/models/model_user_info.dart';

import 'common_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sparky/models/model_preset.dart';
import 'dart:math';


class ProfileScreen extends StatefulWidget {
  

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with WidgetsBindingObserver {
  

  _ProfileScreenState();

  PacketC2SComicDetailInfo c2sComicDetailInfo = PacketC2SComicDetailInfo(); //Todo need a User info packet

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
    // c2sComicDetailInfo.generate();
    // await c2sComicDetailInfo.fetchBytes();
    setState(() {});
  }


  // final Profile profile;

  // ProfileHeader(this.profile);

  @override
  Widget build(BuildContext context) {
    // ModelUserInfo.getInstance().loggedIn = true; //Todo need to applying login page like notification page
    // final topPadding = MediaQuery
    //     .of(context)
    //     .padding
    //     .top;

    // final headerGradient = RadialGradient(
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
              color: Colors.black, 
            ),
            backgroundColor: Colors.white, //Color.fromRGBO(21, 24, 45, 1.0),
            //Color(0xff202a30), //Colors.black87, // Color(0xFF5986E1),
            centerTitle: true,

            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                width: ManageDeviceInfo.resolutionWidth * 0.7,
                /* child: ModelUserInfo.getInstance().photoUrl == null
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
                    : */ 
                  child: Text(
                        'Profile',
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
          ProfileHeader(), //Todo Need to pass Profile data here
          // QuickActions(),
          MainMenu(),
        ],
      ),
    );
  }


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

    final headerGradient = RadialGradient(
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

    var headerHeight = ManageDeviceInfo.resolutionHeight * 0.3;

    return Container(
      height: headerHeight,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        boxShadow: <BoxShadow>[
          BoxShadow(spreadRadius: 2.0,
              blurRadius: 4.0,
              offset: Offset(0.0, 1.0),
              color: Colors.black38),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // linear gradient
          Container(
            height: headerHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[ //7928D1
                    Colors.white70, Colors.white],//const Color(0xFF7928D1), const Color(0xFF9A4DFF)],
                  stops: <double>[0.3, 0.5],
                  begin: Alignment.topRight, end: Alignment.bottomLeft
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: topPadding, left: 15.0, right: 15.0, bottom: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                ),
                Padding(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.notifications_none, color: Colors.white, size: 30.0,),
            onPressed: () {}),
      ],
    );
  }

  Widget _buildTitle() {
    return Text("Profile",
        style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 40.0,
            letterSpacing: 1.0));
  }

  /// The avatar consists of the profile image, the users name and location
  Widget _buildAvatar() {
    final mainTextStyle = TextStyle(fontFamily: 'Lato',
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 20.0);
    final subTextStyle = TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        color: Colors.black87,
        fontWeight: FontWeight.w700);

    return Row(
      children: <Widget>[
        Container(
          width: 70.0, height: 60.0,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/catHouse.jpg"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26, blurRadius: 5.0, spreadRadius: 1.0),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.only(right: 20.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('My Name', style: mainTextStyle),
            Text('My Location', style: subTextStyle),
          ],
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            
          },
          )
      ],
    );
  }

  Widget _buildFollowerStats() {
    return Row(
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
    final titleStyle = TextStyle(
        fontSize: 16.0,
        fontFamily: 'Lato',
        color: Colors.black);
    final valueStyle = TextStyle(
        fontFamily: 'Lato',
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.black);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title, style: titleStyle),
        Text(value, style: valueStyle),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 30.0,
      width: 1.0,
      color: Colors.black54,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}


class MainMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: ManageDeviceInfo.resolutionHeight * 0.5),
      child: ListView(
        padding: EdgeInsets.only(left: ManageDeviceInfo.resolutionWidth * 0.01, top: ManageDeviceInfo.resolutionHeight * 0.02, ),
        children: <Widget>[
          _buildListItem("History", Icons.history, () {}),
          _buildListItem("Favourites", Icons.favorite, () {}),
          _buildListItem("Presents", Icons.card_giftcard, () {}),
          _buildListItem("Friends", Icons.people, () {}),
          _buildListItem("Achievement", Icons.stars, () {}),
        ],
      ),
    );
  }

  Widget _buildListItem(String title, IconData iconData, VoidCallback action) {
    final textStyle = TextStyle(
        color: Colors.black54, fontSize: 18.0, fontWeight: FontWeight.w600);

    return InkWell(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 35.0,
              height: 35.0,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(5.0),
              ),
              alignment: Alignment.center,
              child: Icon(iconData, color: Colors.white, size: 24.0),
            ),
            Text(title, style: textStyle),
            Expanded(child: Container()),
            IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.black26),
                onPressed: action)
          ],
        ),
      ),
    );
  }

}


/* class QuickActions extends StatelessWidget {

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

    return Container(
      constraints: const BoxConstraints(maxHeight: 120.0),
      margin: const EdgeInsets.only(top: 20.0),
      child: Align(
        alignment: Alignment.center,
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(
                left: 10.0, bottom: 20.0, right: 10.0, top: 10.0),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildAction(
                  "Live\nBroadcast", () {}, Colors.blue, blueGradient,
                  AssetImage("images/야옹이.png")),
              _buildAction(
                  "My\nWallet", () {}, Colors.purple, purpleGraient,
                  AssetImage("images/dragonBall.png")),
              _buildAction(
                  "Game\nCenter", () {}, Colors.red, redGradient,
                  AssetImage("images/joystick.png")),
            ]
        ),
      ),
    );
  }

  Widget _buildAction(String title, VoidCallback action, Color color,
      Gradient gradient, ImageProvider backgroundImage) {
    final textStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        fontFamily: 'Lato');

    return GestureDetector(
      onTap: action,
      child: Container(
        margin: const EdgeInsets.only(right: 5.0, left: 5.0),
        width: 150.0,
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black38,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 1.0)),
            ],
            gradient: gradient
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Transform.rotate(
                angle: -3.14 / 4.8,
                alignment: Alignment.centerRight,
                child: ClipPath(
                  clipper: _BackgroundImageClipper(),
                  child: Container(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, right: 0.0, left: 60.0),
                    child: Image(
                      width: 90.0,
                      height: 90.0,
                      image: backgroundImage != null
                          ? backgroundImage
                          : AssetImage("images/야옹이.png"),
                    ),
                  ),
                ),
              ),
            ), // END BACKGROUND IMAGE

            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text(title, style: textStyle),
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
    final path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

} */

  




