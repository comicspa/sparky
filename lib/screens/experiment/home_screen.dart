import 'package:flutter/material.dart';
import 'package:sparky/screens/library.dart';
import 'package:sparky/screens/more.dart';
import 'package:sparky/screens/creator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5986E1),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'images/ComicSpa_logo.png',
              width: 88,
              height: 21.25,
            ),
            Padding(padding: const EdgeInsets.only(left: 8.0)),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Image.asset(
              'images/Comi.png',
              width: 21.5,
              height: 18.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Image.asset(
              'images/search.png',
              width: 21.5,
              height: 18.5,
            ),
          ),
        ],
      ),
      bottomNavigationBar: TabBar(
        labelStyle: TextStyle(fontSize: 10.0),
        indicatorWeight: 0.1,
        controller: controller,
        tabs: <Widget>[
          Tab(text: 'Home', icon: Icon(Icons.home)),
          Tab(text: 'Library', icon: Icon(Icons.library_books)),
          Tab(text: 'Creator', icon: Icon(Icons.palette)),
          Tab(text: 'More', icon: Icon(Icons.menu)),
        ],
      ),
      body: TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomeScreen(),
          LibraryScreen(),
          CreatorScreen(),
          MoreScreen(),
        ],
      ),
    );
  }
}

//        new BottomNavigationBar(
//            type: BottomNavigationBarType.fixed,
//            items: [
//              new BottomNavigationBarItem(
//                  backgroundColor: Colors.white,
//                  icon: new Image.asset(
//                    'images/HomeKey_home_on.png',
//                    width: 23,
//                    height: 20,
//                  ),
//                  title: new Text('Home',
//                      style: new TextStyle(
//                          color: const Color(0xFF06244e), fontSize: 11.0))),
//              new BottomNavigationBarItem(
//                  icon: new Image.asset(
//                    'images/HomeKey_library_on.png',
//                    width: 23,
//                    height: 20,
//                  ),
//                  title: new Text('Library',
//                      style: new TextStyle(
//                          color: const Color(0xFF06244e), fontSize: 11.0))),
//              new BottomNavigationBarItem(
//                  icon: new Image.asset(
//                    'images/HomeKey_creator_on.png',
//                    width: 23,
//                    height: 20,
//                  ),
//                  title: new Text(
//                    'Creators',
//                    style: new TextStyle(
//                        color: const Color(0xFF06244e), fontSize: 11.0),
//                  )),
//              new BottomNavigationBarItem(
//                  icon: new Image.asset(
//                    'images/HomeKey_etc_on.png',
//                    width: 23,
//                    height: 20,
//                  ),
//                  title: new Text(
//                    'More',
//                    style: new TextStyle(
//                        color: const Color(0xFF06244e), fontSize: 11.0),
//                  ))
//            ]));
