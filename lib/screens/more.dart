import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_device_info.dart'; // use this to make all the widget size responsive to the device size.
import 'package:sparky/models/model_localization_info.dart';
import 'package:sparky/screens/account/sign_in_up_landing_page.dart';
import 'package:sparky/screens/more/creator_submenu.dart';
import 'package:sparky/screens/more/setting_submenu.dart';
import 'package:sparky/screens/more/version_info.dart';
import 'more_submenu_comming_soon.dart';
import 'package:sparky/screens/more/service_info_submenu.dart';
import 'package:sparky/packets/packet_c2s_user_info.dart';
import 'package:sparky/screens/more/translator_submenu.dart';
import 'package:sparky/screens/more/shop.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => new _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> with WidgetsBindingObserver {

  PacketC2SUserInfo c2sUserInfo = new PacketC2SUserInfo();


  @override
  void initState() {
    print('[more : initState]');
    WidgetsBinding.instance.addObserver(this);
    super.initState();
//    c2STodayPopularComicInfo.generate(0, 0);   // generating packet
//    c2SViewComic.generate();
  }

  @override
  void dispose() {

    print('[more : dispose]');

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  final textStyle = TextStyle(
        color: Colors.black87, fontSize: ManageDeviceInfo.resolutionHeight * 0.025, fontWeight: FontWeight.w600);
  



  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: AlertDialog(
            title: Text(ModelLocalizationInfo.getText('dialog', 'exit_dialog_1')),
            content: Text(ModelLocalizationInfo.getText('dialog', 'exit_dialog_2')),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text(ModelLocalizationInfo.getText('common', 'text_no')),
              ),
              FlatButton(
                onPressed: () { //todo need more processing for logout
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
                child: Text(ModelLocalizationInfo.getText('common', 'text_yes')),
              ),
            ],
          ),
        ) ??
        false;
  }

 
  
  
  @override
  Widget build(BuildContext context) {
    // Todo Currently this screen is used for testing viewer
    return ListView(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: ManageDeviceInfo.resolutionWidth * 1.0,
                  height: ManageDeviceInfo.resolutionHeight * 0.18,
                  color: Color.fromRGBO(21, 24, 45, 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: <Widget>[
                      SizedBox(
                        height: ManageDeviceInfo.resolutionHeight * 0.05,
                        width: ManageDeviceInfo.resolutionWidth * 0.25,
                        child: OutlineButton(
                          highlightedBorderColor: Colors.redAccent,
                          shape: StadiumBorder(),
                          borderSide: BorderSide(color: Colors.white70),
                          onPressed: () {
                            Navigator.push<Widget>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SubMenuComingSoonScreen(ModelLocalizationInfo.getText('common', 'button_redeem')),
                                ));
                          },
                          child: Text(
                            ModelLocalizationInfo.getText('common', 'button_redeem'),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ManageDeviceInfo.resolutionWidth * 0.1,),
                      SizedBox(
                        height: ManageDeviceInfo.resolutionHeight * 0.05,
                        width: ManageDeviceInfo.resolutionWidth * 0.25,
                        child: OutlineButton(
                          highlightedBorderColor: Colors.redAccent,
                          shape: StadiumBorder(),
                          borderSide: BorderSide(color: Colors.white70),
                          onPressed: () {
                            Navigator.push<Widget>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShopMenuScreen(ModelLocalizationInfo.getText('common', 'button_shop')),
                                ));
                          },
                          child: Text(
                            ModelLocalizationInfo.getText('common', 'button_shop'),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
              ],
            ),
            Divider(
              thickness: ManageDeviceInfo.resolutionHeight * 0.03,
              color: Colors.grey[300],
            ),
            
            
            ListTile(
              leading: Icon(Icons.palette),
              title: Text(
                ModelLocalizationInfo.getText('more', 'title_creator'),
                textAlign: TextAlign.left,
                style: textStyle,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push<Widget>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatorSubmenuScreen(ModelLocalizationInfo.getText('more', 'title_creator')),
                  ),
                );
              },
            ),
            
            ListTile(
              leading: Icon(Icons.translate),
              title: Text(
                ModelLocalizationInfo.getText('more', 'title_translator'),
                textAlign: TextAlign.left,
                style: textStyle,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push<Widget>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TranslatorSubmenuScreen(ModelLocalizationInfo.getText('more', 'title_translator')),
                  ),
                );
              },
            ),
            Divider(
              thickness: ManageDeviceInfo.resolutionHeight * 0.03,
              color: Colors.grey[300],
            ),
            
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                ModelLocalizationInfo.getText('more', 'menu_service_info'),
                textAlign: TextAlign.left,
                style: textStyle
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push<Widget>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ServiceInfoSubmenuScreen(ModelLocalizationInfo.getText('more', 'menu_service_info')),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                ModelLocalizationInfo.getText('more', 'menu_setting'),
                textAlign: TextAlign.left,
                style: textStyle,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push<Widget>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingSubmenuPage(titleText: ModelLocalizationInfo.getText('more', 'menu_setting')),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                ModelLocalizationInfo.getText('more', 'menu_about'),
                textAlign: TextAlign.left,
                style: textStyle,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push<Widget>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutContentsWidgets(titleText: ModelLocalizationInfo.getText('more', 'menu_about')),
                  ),
                );
              },
            ),
            Divider(
              thickness: ManageDeviceInfo.resolutionHeight * 0.03,
              color: Colors.grey[300],
            ),
            Container(
              padding: EdgeInsets.only(top: ManageDeviceInfo.resolutionHeight * 0.05, bottom: ManageDeviceInfo.resolutionHeight * 0.05),
              color: Colors.white60,
              height: ManageDeviceInfo.resolutionHeight * 0.18,
              child: FlatButton(
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.push<Widget>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInUpLandPage(),
                    ),
                  );
                },
                child: Text(
                  ModelLocalizationInfo.getText('common', 'sign_in') 
                  + ModelLocalizationInfo.getText('common', 'or') 
                  + ModelLocalizationInfo.getText('common', 'sign_out'),
                  style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
                  
                ),
              ),
            ),
            
           
            
            Divider(
              thickness: ManageDeviceInfo.resolutionHeight * 0.03,
              color: Colors.grey[300],
            ),
           
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                ModelLocalizationInfo.getText('common', 'sign_out'),
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                _exitApp(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
