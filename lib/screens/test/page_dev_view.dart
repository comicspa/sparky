import 'package:flutter/material.dart';

import 'package:sparky/manage/manage_firebase_storage.dart';

class PageDevView extends StatelessWidget {
  String url1;
  String url2;
  String url3;
  String url4;
  String url5;

  @override
  Widget build(BuildContext context) {
    //url1 = ManageFirebaseStorage.getDownloadURL('comics/01.jpg');
    //url2 = ManageFirebaseStorage.getDownloadURL('comics/02.jpg');
    //url3 = ManageFirebaseStorage.getDownloadURL('comics/03.jpg');
    //url4 = ManageFirebaseStorage.getDownloadURL('comics/04.jpg');
    //url5 = ManageFirebaseStorage.getDownloadURL('comics/05.jpg');

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
          //'https://s3.ap-northeast-2.amazonaws.com/test.webtoon/01.jpg',
          'https://firebasestorage.googleapis.com/v0/b/comicspa-248608.appspot.com/o/comics%2F01.jpg?alt=media&token=b86e5d83-cca9-4e7e-81b2-089770127c01',
        ),
        new Image.network(
          //'https://s3.ap-northeast-2.amazonaws.com/test.webtoon/02.jpg',
          'https://firebasestorage.googleapis.com/v0/b/comicspa-248608.appspot.com/o/comics%2F02.jpg?alt=media&token=0d8d28e6-d60f-4bc8-ac43-9b764584e749',
        ),
        new Image.network(
          //'https://s3.ap-northeast-2.amazonaws.com/test.webtoon/03.jpg',
          'https://firebasestorage.googleapis.com/v0/b/comicspa-248608.appspot.com/o/comics%2F03.jpg?alt=media&token=9999f53e-5f0c-46e7-bf42-f4f3087518db',
        ),
        new Image.network(
          //'https://s3.ap-northeast-2.amazonaws.com/test.webtoon/04.jpg',
          'https://firebasestorage.googleapis.com/v0/b/comicspa-248608.appspot.com/o/comics%2F04.jpg?alt=media&token=92afec09-e153-48fb-81a8-37e2f70fcb37',
        ),
        new Image.network(
          //'https://s3.ap-northeast-2.amazonaws.com/test.webtoon/05.jpg',
          'https://firebasestorage.googleapis.com/v0/b/comicspa-248608.appspot.com/o/comics%2F05.jpg?alt=media&token=fe05a361-eec5-418a-b8ec-7bdb74d7ac7f',
        ),
      ]),
    ))));
  }
}
