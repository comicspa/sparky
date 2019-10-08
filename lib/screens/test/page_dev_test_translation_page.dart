import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart';

/* //Todo need model with userID, 언어별 리스트, top 7 (조회 수 순위별로) , 
  Todo 번역 작품별 보기로 연결 할 인자, 현재 디바이스 언어 체크 ( 원작이 동일어 인 경우 현재 페이지 안보여줌: 이부분은 )*/

class TranslationListScreen extends StatefulWidget {
  TranslationListScreen({Key key}) : super(key: key);

  _TranslationListScreenState createState() => _TranslationListScreenState();
}

class _TranslationListScreenState extends State<TranslationListScreen> {
  @override

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  'Language Screen',
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
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Card(
          child: ListTile(
            onTap: (){
              //Todo connect to the Viewer page
            },
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              //Todo add Url backgroundImage: NetworkImage(url),
              ),
            title: Text('User ID'),
            subtitle: Text(
                  'Feb 26 · views ★',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
            
            trailing: Icon(Icons.chevron_right),       
          ),
        ),
        CustomListItemTwo(
        avatar: Container(
          decoration: const BoxDecoration(color: Colors.blue),
        ),
        userId: 'IamTheBest',
        aboutMe: 'I will continue translating this title till end and I promise that.  Also this needs to be tested for checking long description',
        
        publishDate: 'Feb 26',
        views: '12 mins',
      ),
      ],
    )
    );
  }


}

class _ArticleDescription extends StatelessWidget {
  _ArticleDescription({
    Key key,
    this.userId,
    this.aboutMe,
    this.author,
    this.publishDate,
    this.views,
  }) : super(key: key);

  final String userId;
  final String aboutMe;
  final String author;
  final String publishDate;
  final String views;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$userId',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                '$aboutMe',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                '$author',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate · $views ★',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class CustomListItemTwo extends StatelessWidget {
  CustomListItemTwo({
    Key key,
    this.avatar,
    this.userId,
    this.aboutMe,
    this.publishDate,
    this.views,
  }) : super(key: key);

  final Widget avatar;
  final String userId;
  final String aboutMe;
  final String publishDate;
  final String views;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: avatar,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  userId: userId,
                  aboutMe: aboutMe,
                  publishDate: publishDate,
                  views: views,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}