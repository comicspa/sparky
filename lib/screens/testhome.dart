import 'package:flutter/material.dart';
//import 'package:carousel_pro/carousel_pro.dart';


class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => new _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            child: ListTile(
                title: Image.asset(
                  'images/mainTest.jpg',
                  height: 310,
                  fit: BoxFit.fill,
                ),
                subtitle: Text('맞춤 피처드')),
          ),
          Text(
            'Headline',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 160.0,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Center(
                  child: Image.asset(
                    'images/batman.jpg',
                    height: 155,
                    width: 105,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 160.0,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Center(
                  child: Image.asset(
                    'images/catHouse.jpg',
                    height: 155,
                    width: 105,
                  ),
                ),
              ),
            ),
          ),
          Text(
            'Demo Headline 2',
            style: TextStyle(fontSize: 18),
          ),
          Card(
            child:
                ListTile(title: Text('Motivation $int'), subtitle: Text('재미남')),
          ),
          SizedBox(
            height: 160.0,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Center(
                  child: Image.asset(
                    'images/할리퀸.jpg',
                    height: 155,
                    width: 105,
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
                title: Text('Motivation $int'), subtitle: Text('재미없음')),
          ),
          SizedBox(
            height: 160.0,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) => Card(
                child: Center(
                  child: Image.asset(
                    'images/dragonBall.jpg',
                    height: 155,
                    width: 105,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[
//        Parallax.outside(
//          controller: _scrollController,
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              Column(
//                children: <Widget>[
//                  Container(
//                    color: Colors.red,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.pink,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.lightGreen,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.orange,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.teal,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.purple,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.grey,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.lime,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.indigo,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.yellow,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.green,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.blue,
//                    height: 200.0,
//                  ),
//                ],
//              ),
//              Column(
//                children: <Widget>[
//                  Container(
//                    color: Colors.red,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.pink,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.lightGreen,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.orange,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.teal,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.purple,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.grey,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.lime,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.indigo,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.yellow,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.green,
//                    height: 200.0,
//                  ),
//                  Container(
//                    color: Colors.blue,
//                    height: 200.0,
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ),
//        ListView.builder(
//          //TODO ListView.builder dynamic하게 증가할 수 있게 만들기(참조: https://medium.com/@DakshHub/flutter-displaying-dynamic-contents-using-listview-builder-f2cedb1a19fb)
//
//          controller: _scrollController,
//          itemBuilder: buildItem,
//          itemCount: 20,
//        )
//      ],
//    );
//  }
//
//  Widget buildItem(BuildContext context, int index) {
//    var mode = index % 4;
//    switch (mode) {
//      case 0:
//        return new Parallax.inside(
//          child: new Image.network(
//              'https://flutter.io/images/homepage/header-illustration.png'),
//          mainAxisExtent: 150.0,
//        );
//      case 1:
//        return new Parallax.inside(
//          child: new Image.network(
//              'http://t.wallpaperweb.org/wallpaper/nature/3840x1024/9XMedia1280TripleHorizontalMountainsclouds.jpg'),
//          mainAxisExtent: 150.0,
//          direction: AxisDirection.right,
//        );
//      case 2:
//        return new Parallax.inside(
//          child: new Image.network(
//              'https://flutter.io/images/homepage/header-illustration.png'),
//          mainAxisExtent: 150.0,
//          flipDirection: true,
//        );
//      default:
//        return new Parallax.inside(
//          child: new Image.network(
//              'http://t.wallpaperweb.org/wallpaper/nature/3840x1024/9XMedia1280TripleHorizontalMountainsclouds.jpg'),
//          mainAxisExtent: 150.0,
//          direction: AxisDirection.left,
//        );
//    }
//  }
