import 'package:flutter/material.dart';

class PageDevTestViewImage extends StatelessWidget {

  String _url1 = '';
  String _url2 = '';
  String _url3 = '';
  String _url4 = '';
  String _url5 = '';

  void _init()
  {
    //test webp
    _url1 = 'https://firebasestorage.googleapis.com/v0/b/enhanced-grid-251003.appspot.com/o/test%2F01.webp?alt=media&token=6158f23e-2ca0-4fb6-ad68-8bba31cb8d2f';
    _url2 = 'https://firebasestorage.googleapis.com/v0/b/enhanced-grid-251003.appspot.com/o/test%2F02.webp?alt=media&token=0e3e7198-3485-41e3-b99e-cdea4132c6b5';
    _url3 = 'https://firebasestorage.googleapis.com/v0/b/enhanced-grid-251003.appspot.com/o/test%2F03.webp?alt=media&token=5eb98a59-754b-4a74-8d60-0b2a3a210d77';
    _url4 = 'https://firebasestorage.googleapis.com/v0/b/enhanced-grid-251003.appspot.com/o/test%2F04.webp?alt=media&token=8130cdad-785f-4d7d-b587-b68dd9d9d1df';
    _url5 = 'https://firebasestorage.googleapis.com/v0/b/enhanced-grid-251003.appspot.com/o/test%2F05.webp?alt=media&token=4ace6bc9-5203-4859-a4fa-15ccab106998';
  }

  @override
  Widget build(BuildContext context) {

    _init();

    return new Material(
        child: new Container(
            child: new SingleChildScrollView(
                child: new ConstrainedBox(
                  constraints: new BoxConstraints(),
                  child: new Column(children: <Widget>[
                    new Text(
                      '퀸 제1화',
                      textDirection: TextDirection.ltr,
                      style: new TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[600],
                      ),
                    ),
                    new Image.network(
                      _url1,
                    ),
                    new Image.network(
                      _url2,
                    ),
                    new Image.network(
                      _url3,
                    ),
                    new Image.network(
                      _url4,
                    ),
                    new Image.network(
                      _url5,
                    ),
                  ]),
                ))));
  }
}
