import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:sparky/models/model_localization_info.dart';
import 'package:sparky/models/model_user_info.dart';
import 'package:sparky/screens/account/sign_in_up_landing_page.dart';





class NotificationScreen extends StatefulWidget {


  @override
  _NotificationScreenState createState() => new _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>  with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)
  {
    print('state = $state');
  }


  @override
  Widget build(BuildContext context) {
    return ModelUserInfo.getInstance().signedIn
        ? notificationPage(context)
        : SignInUpLandPage();
  }

  Column notificationPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          child: Icon(
            Icons.info_outline,
            color: Color.fromRGBO(21, 24, 45, 1.0),
            size: ManageDeviceInfo.resolutionHeight * 0.05,
          ),
        ),
        SizedBox(
          width: ManageDeviceInfo.resolutionWidth * 0.7,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Please sign in or sign up!',
              maxLines: 2,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                fontFamily: 'Lato',
              ),
            ),
          ),
        ),
        
        // new NotificationWidget(),
      ],
    );
  }
}

class PopupMenuButtonWidget extends StatelessWidget {
  const PopupMenuButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PopupMenuButton<int>(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(ModelLocalizationInfo.getText('inbox','menu_delete')),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(ModelLocalizationInfo.getText('inbox','menu_reject')),
          ),
          PopupMenuItem(
            value: 3,
            child: Text("Anything else?"),
          ),
        ],
      );
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: ManageDeviceInfo.resolutionWidth * 0.15,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: CircleAvatar(
              radius: ManageDeviceInfo.resolutionWidth * 0.05,
              child: Image(
                image: AssetImage('images/Comi.png'
                   //Todo make NetworkAsset later
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          width: ManageDeviceInfo.resolutionWidth * 0.55,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
//                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '[Update] Noticfication title and if the title is too long, it will provide 2 lines at the max',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '1분 전, 1시간 전, 1일 전',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: ManageDeviceInfo.resolutionWidth * 0.2,
          child: Image(
              image: AssetImage(
                'images/야옹이.png', //Todo make NetworkAsset later
              ),
              fit: BoxFit.cover),
        ),
        SizedBox(
          width: ManageDeviceInfo.resolutionWidth * 0.1,
          child: PopupMenuButtonWidget(),
        ),
      ],
    );
  }
}
