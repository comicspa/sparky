import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.

import 'dart:ui' as ui;

class DrawRect extends StatefulWidget {
  @override
  _DrawRectState createState() => _DrawRectState();
}

class _DrawRectState extends State<DrawRect> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Form(
                  key: _formKey,
                  child: SizedBox(
                    height: ManageDeviceInfo.resolutionHeight * 0.38,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          height: ManageDeviceInfo.resolutionHeight * 0.2,
                          child: TextFormField(
                            textInputAction: TextInputAction.send,
                            autofocus: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                                hintText: 'You may start typing',
                                contentPadding: EdgeInsets.all(
                                    ManageDeviceInfo.resolutionHeight * 0.01)

//                              border: OutlineInputBorder(),
//                              focusedBorder: OutlineInputBorder(
//                                borderSide: BorderSide(
//                                  color: Colors.greenAccent,
//                                ),
//                              ),
//                              enabledBorder: OutlineInputBorder(
//                                borderSide: BorderSide(
//                                  color: Colors.redAccent,
//                                ),
//                              ),
//                              contentPadding: EdgeInsets.all(
//                                  ManageDeviceInfo.resolutionWidth * 0.02),
                                ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: SizedBox(
                                height:
                                    ManageDeviceInfo.resolutionHeight * 0.035,
                                child: RaisedButton(
                                  shape: StadiumBorder(),
                                  onPressed: () {
                                    // Validate will return true if the form is valid, or false if
                                    // the form is invalid.
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ManageDeviceInfo.resolutionWidth * 0.1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: SizedBox(
                                height:
                                    ManageDeviceInfo.resolutionHeight * 0.035,
                                child: RaisedButton(
                                  shape: StadiumBorder(),
                                  onPressed: () {
                                    // Validate will return true if the form is valid, or false if
                                    // the form is invalid.
                                    if (_formKey.currentState.validate()) {
                                      // Process data.
                                    }
                                  },
                                  child: Text('Submit'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(
                                  ManageDeviceInfo.resolutionHeight * 0.02),
                              child: SizedBox(
                                height:
                                    ManageDeviceInfo.resolutionHeight * 0.035,
                                child: RaisedButton(
                                  shape: StadiumBorder(),
                                  onPressed: () {
                                    // Validate will return true if the form is valid, or false if
                                    // the form is invalid.
                                    if (_formKey.currentState.validate()) {
                                      // Process data.
                                    }
                                  },
                                  child: Text('Language'),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
          debugPrint("hello");
        },
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 100,
              top: 200,
              child: Container(
                width: 200,
                height: 100,
                color: Colors.yellowAccent,
                child: CustomPaint(
                  painter: (MyRect()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyRect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(
      new Rect.fromLTWH(0.0, 0.0, 150.0, 50.0),
      paint,
    );
  }

//  @override
//  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
//    return new Path()
//      ..fillType = PathFillType.evenOdd
//      ..addPath(getOuterPath(rect), Offset.zero);
//  }

  @override
  bool shouldRepaint(MyRect oldDelegate) {
    return false;
  }
}

//class RectsExample extends StatefulWidget {
//  @override
//  _RectsExampleState createState() => _RectsExampleState();
//}
//
//class _RectsExampleState extends State<RectsExample> {
//  int _index = -1;
//  final _formKey = GlobalKey<FormState>();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: Rects(
//          rects: [
//            Rect.fromLTRB(10, 20, 30, 40),
//            Rect.fromLTRB(40, 60, 80, 100),
//          ],
//          selectedIndex: _index,
//          onSelected: (index) {
//            showDialog(
//                context: context,
//                builder: (BuildContext context) {
//                  return AlertDialog(
//                    content: Form(
//                      key: _formKey,
//                      child: Column(
//                        mainAxisSize: MainAxisSize.min,
//                        children: <Widget>[
//                          Padding(
//                            padding: EdgeInsets.all(8.0),
//                            child: TextFormField(),
//                          ),
//                          Padding(
//                            padding: EdgeInsets.all(8.0),
//                            child: TextFormField(),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.all(8.0),
//                            child: RaisedButton(
//                              child: Text("Submit"),
//                              onPressed: () {
//                                if (_formKey.currentState.validate()) {
//                                  _formKey.currentState.save();
//                                }
//                              },
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                  );
//                });
//          },
//          onSelected: (index) {
//            setState(() {
//              _index = index;
//            });
//          },
//        ),
//      ),
//    );
//  }
//}
//
//class Rects extends StatelessWidget {
//  final List<Rect> rects;
//  final void Function(int) onSelected;
//  final int selectedIndex;
//
//  const Rects({
//    Key key,
//    @required this.rects,
//    @required this.onSelected,
//    this.selectedIndex = -1,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTapDown: (details) {
//        RenderBox box = context.findRenderObject();
//        final offset = box.globalToLocal(details.globalPosition);
//        final index = rects.lastIndexWhere((rect) => rect.contains(offset));
//        if (index != -1) {
//          onSelected(index);
//          return;
//        }
//        onSelected(-1);
//      },
//      child: CustomPaint(
//        size: Size(320, 240),
//        painter: _RectPainter(rects, selectedIndex),
//      ),
//    );
//  }
//}
//
//class _RectPainter extends CustomPainter {
//  static Paint _red = Paint()..color = Colors.red;
//  static Paint _blue = Paint()..color = Colors.blue;
//
//  final List<Rect> rects;
//  final int selectedIndex;
//
//  _RectPainter(this.rects, this.selectedIndex);
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    var i = 0;
//    for (Rect rect in rects) {
//      canvas.drawRect(rect, i++ == selectedIndex ? _red : _blue);
//    }
//  }
//
//  @override
//  bool shouldRepaint(CustomPainter oldDelegate) {
//    return true;
//  }
//}
