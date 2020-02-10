
import 'package:flutter/material.dart';
import 'package:sparky/manage/manage_in_app_purchase.dart';
import 'package:sparky/manage/manage_toast_message.dart';


class PageDevTestInAppPurchase extends StatefulWidget {
  @override
  _PageDevTestInAppPurchaseState createState() => new _PageDevTestInAppPurchaseState();
}

class _PageDevTestInAppPurchaseState extends State<PageDevTestInAppPurchase> {
  // TODO Add build() method

  ManageInAppPurchase _manageInAppPurchase;


  @override
  void initState()
  {
    if(null == _manageInAppPurchase)
      _manageInAppPurchase = new ManageInAppPurchase();
    _manageInAppPurchase.initialize();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InAppPurchase Test'),
      ),
      body: _buildSuggestions(context),
    );
  }

  @override
  void dispose()
  {
    if(null != _manageInAppPurchase)
     {
       _manageInAppPurchase.dispose();
       _manageInAppPurchase = null;
     }

    ManageToastMessage.cancel();
    super.dispose();
  }

  Widget
  _buildSuggestions(BuildContext context)
  {
    return ListView(
      children: ListTile.divideTiles(
        context: context,
        tiles: [

          ListTile(
            title: Text('Go to Next Page !!'),
            onTap: (){

              Navigator.of(context).pushReplacementNamed('/PageDevTestApply');

            },
          ),

          ListTile(
            title: Text('buy item_10'),
            onTap: (){


            },
          ),
          ListTile(
            title: Text('buy item_50'),
            onTap: (){

            },
          ),

          ListTile(
            title: Text('buy item_100'),
            onTap: (){


            },
          ),

          ListTile(
            title: Text('buy item_200'),
            onTap: (){


            },
          ),

          ListTile(
            title: Text('buy item_300'),
            onTap: (){


            },
          ),


          ListTile(
            title: Text('buy item_500'),
            onTap: (){


            },
          ),


        ], ).toList(), ); }

}