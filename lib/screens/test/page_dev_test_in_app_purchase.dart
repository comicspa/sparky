
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
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
    _manageInAppPurchase.initialize(_callbackInAppPurchase);

    super.initState();
  }

  //
  void _callbackInAppPurchase(String purchaseStatus,bool updateUIState)
  {
    print('[PageDevTestInAppPurchase : _callbackInAppPurchase] - $purchaseStatus');

    switch(purchaseStatus)
    {
      case 'pending':
        {

        }
        break;

      case 'purchased':
        {
          ManageToastMessage.showShort('Item Purchased');
        }
        break;

      case 'error':
        {


        }
        break;

      default:
        break;
    }


    if(true == updateUIState)
    {
      setState(() {

      });
    }
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

              _manageInAppPurchase.buy('item_10');

            },
          ),
          ListTile(
            title: Text('buy item_50'),
            onTap: (){

              _manageInAppPurchase.buy('item_50');

            },
          ),

          ListTile(
            title: Text('buy item_100'),
            onTap: (){

              _manageInAppPurchase.buy('item_100');

            },
          ),

          ListTile(
            title: Text('buy item_200'),
            onTap: (){

              _manageInAppPurchase.buy('item_200');

            },
          ),

          ListTile(
            title: Text('buy item_300'),
            onTap: (){

              _manageInAppPurchase.buy('item_300');

            },
          ),

          ListTile(
            title: Text('buy item_500'),
            onTap: (){

              _manageInAppPurchase.buy('item_500');

            },
          ),


        ], ).toList(), ); }

}