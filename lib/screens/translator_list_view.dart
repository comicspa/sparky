import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:transparent_image/transparent_image.dart';

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
                  'Translators',
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
           
          ),
        ),
      ), 
    body: ListView(
      padding: EdgeInsets.all(6.0),
      children: <Widget>[
       
        TranslatorListWidget(
        avatar: SizedBox(
          width: ManageDeviceInfo.resolutionWidth * 0.116,
          height: ManageDeviceInfo.resolutionWidth * 0.116,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: ModelUserInfo.getInstance().photoUrl,
            ),
          ),
        ),
        userId: 'IamTheBest',
        aboutMe: 'I will continue translating this title till end and I promise that.  Also this needs to be tested for checking long description',
        
        publishDate: 'Feb 26',
        views: '123,234',
      ),
      Divider(),
       
      ],
    )
    );
  }


}

class _AboutMeDescription extends StatelessWidget {
  _AboutMeDescription({
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: ManageDeviceInfo.resolutionHeight * 0.003)),
              Text(
                '$aboutMe',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ManageDeviceInfo.resolutionWidth * 0.033,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$publishDate · $views ★',
                    style: TextStyle(
                      fontSize: ManageDeviceInfo.resolutionWidth * 0.033,
                      color: Colors.black54,
                    ),                    
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class TranslatorListWidget extends StatelessWidget {
  TranslatorListWidget({
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
      padding: EdgeInsets.only(
        left: ManageDeviceInfo.resolutionWidth * 0.042,
        top: ManageDeviceInfo.resolutionHeight * 0.0156, 
        bottom: ManageDeviceInfo.resolutionHeight * 0.0156),
      child: SizedBox(
        height: ManageDeviceInfo.resolutionHeight * 0.12 ,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            avatar,
            
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  ManageDeviceInfo.resolutionWidth * 0.042,
                  0.0,
                  ManageDeviceInfo.resolutionWidth * 0.0005,
                  0.0
                  ),
                child: _AboutMeDescription(
                  userId: userId,
                  aboutMe: aboutMe,
                  publishDate: publishDate,
                  views: views,
                ),
              ),                
            ),
            IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(Icons.chevron_right),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}