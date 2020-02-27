import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class ViewerWithFAB extends StatefulWidget {
  ViewerWithFAB({Key key, }) : super(key: key);

  @override
  _ViewerWithFAB createState() => new _ViewerWithFAB();
}

class _ViewerWithFAB extends State<ViewerWithFAB> {



//  int _counter = 0;
//  ScrollController _hideButtonController;
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
  bool _isVisible;


  @override
  initState(){
    //    SystemChrome.setEnabledSystemUIOverlays([]);

    super.initState();
    _isVisible = true;
// Below code is used when FAB hide/show according to the scroll direction
//    _hideButtonController = new ScrollController();
//
//    _hideButtonController.addListener((){
//      if(_hideButtonController.position.userScrollDirection == ScrollDirection.reverse){
//        if(_isVisible == true) {
//          /* only set when the previous state is false
//             * Less widget rebuilds
//             */
//          print("**** ${_isVisible} up"); //Move IO away from setState
//          setState((){
//            _isVisible = false;
//          });
//        }
//      } else {
//        if(_hideButtonController.position.userScrollDirection == ScrollDirection.forward){
//          if(_isVisible == false) {
//            /* only set when the previous state is false
//               * Less widget rebuilds
//               */
//            print("**** ${_isVisible} down"); //Move IO away from setState
//            setState((){
//              _isVisible = true;
//            });
//          }
//        }
//      }});
  }

//  @override
//  void dispose() {
//    //SystemChrome.restoreSystemUIOverlays();
//    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Center(

        child: GestureDetector(
          onTap: () {
            setState(() { _isVisible = !_isVisible; });
          },
          child: CustomScrollView(
//          controller: _hideButtonController,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.all(0.0),
                sliver: SliverList(
                    delegate: SliverChildListDelegate(
                        <Widget>[
                          Image.asset(
                              'images/01.jpg',
                              fit: BoxFit.fill
                          ),
                          Image.asset(
                            'images/02.jpg',
                          ),
                          Image.asset(
                            'images/03.jpg',
                          ),
                          Image.asset(
                            'images/04.jpg',
                          ),
                          Image.asset(
                            'images/05.jpg',
                          ),

                        ]
                    )
                ),
              )
            ],
          ),
        ),

      ),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: Row(

          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: 35,
              child: FloatingActionButton(
                heroTag: 'btn1',
                backgroundColor: Colors.brown,
                onPressed: (){},
                child: Icon(Icons.translate),
              ),
            ),
            SizedBox(width: 40,),
            Row(
              children: <Widget>[
                Container(
                  height: 35,
                  child: FloatingActionButton(
                    heroTag: 'btn2',
                    onPressed: (){},
                    child: Icon(Icons.arrow_left),
                  ),
                ),

                SizedBox(width: 40,), // need to change it to # input field for jumping to other episode

                Container(
                  height: 35,
                  child: FloatingActionButton(
                    heroTag: 'btn3',
                    onPressed: (){},
                    child: Icon(Icons.arrow_right),
                  ),
                ),
              ],
            ),


          ],
        ),
      ),
    );

  }
}
