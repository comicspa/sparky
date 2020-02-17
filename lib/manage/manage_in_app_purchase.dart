import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparky/manage/manage_shared_preference.dart';
import 'package:sparky/manage/manage_toast_message.dart';



const bool kAutoConsume = true;

//const String _kConsumableId = 'consumable';
//const List<String> _kProductIds = <String>[
//  _kConsumableId,
//  'upgrade',
//  'subscription'
//];


const String _kConsumableId = 'item_10';
const List<String> _kProductIds = <String>[
  _kConsumableId,
  'item_50',
  'item_100',
  'item_200',
  'item_300',
  'item_500'
];


/*
const String _kConsumableId = 'android.test.purchased';
const List<String> _kProductIds = <String>[
  _kConsumableId
];

 */


typedef void CallbackInAppPurchase(String purchaseStatus,bool updateUIState);


class ConsumableStore
{
  static const String _kPrefKey = 'consumables';
  static Future<void> _writes = Future.value();

  static Future<void> save(String id)
  {
    _writes = _writes.then((void _) => _doSave(id));
    return _writes;
  }

  static Future<void> consume(String id)
  {
    _writes = _writes.then((void _) => _doConsume(id));
    return _writes;
  }

  static Future<List<String>> load() async
  {
    return (await SharedPreferences.getInstance()).getStringList(_kPrefKey) ??
        [];
  }

  static Future<void> _doSave(String id) async
  {
    List<String> cached = await load();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.add(id);
    await prefs.setStringList(_kPrefKey, cached);
  }

  static Future<void> _doConsume(String id) async
  {
    List<String> cached = await load();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.remove(id);
    await prefs.setStringList(_kPrefKey, cached);
  }
}



class ManageInAppPurchase
{

  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String _queryProductError;

  CallbackInAppPurchase _callbackInAppPurchase;


  /*
   void loadingPreviousPurchases() async
  {
    final QueryPurchaseDetailsResponse response = await InAppPurchaseConnection.instance.queryPastPurchases();
    if (response.error != null)
    {
      // Handle the error.
    }
    for (PurchaseDetails purchase in response.pastPurchases)
    {
      _verifyPurchase(purchase);  // Verify the purchase following the best practices for each storefront.
      _deliverPurchase(purchase); // Deliver the purchase to the user in your app.
      if (Platform.isIOS)
      {
        // Mark that you've delivered the purchase. Only the App Store requires
        // this final confirmation.
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
    }
  }

  */

  void initialize(callbackInAppPurchase)
  {
    _callbackInAppPurchase = callbackInAppPurchase;

    Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
      _subscription = purchaseUpdated.listen((purchaseDetailsList)
    {
      _listenToPurchaseUpdated(purchaseDetailsList);
    },
    onDone: ()
    {
      _subscription.cancel();
    }, onError: (error)
          {
      // handle error here.
            ManageToastMessage.showShort('[ManageInAppPurchase : initialize] error - ' + error.toString());
    });

    initStoreInfo();

  }


  Future<void> initStoreInfo() async
  {
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable)
    {
      ManageToastMessage.showShort('[ManageInAppPurchase : initStoreInfo] - !isAvailable');

      //setState(()
      //{
      _isAvailable = isAvailable;
      _products = [];
      _purchases = [];
      _notFoundIds = [];
      _consumables = [];
      _purchasePending = false;
      _loading = false;
      //});

      return;
    }

    ProductDetailsResponse productDetailResponse =  await _connection.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null)
    {
      ManageToastMessage.showShort('[ManageInAppPurchase : initStoreInfo] - '+productDetailResponse.productDetails.toString());

      //setState(()
      //{
      _queryProductError = productDetailResponse.error.message;
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = [];
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = [];
      _purchasePending = false;
      _loading = false;
      //});

      return;
    }

    //productDetailResponse.notFoundIDs

    //if(null != productDetailResponse.notFoundIDs)
    //{
    //  ManageToastMessage.showShort('[ManageInAppPurchase : initStoreInfo] - productDetailResponse.notFoundIDs : '+productDetailResponse.notFoundIDs.toString());
    //  return;
    //}

    if (productDetailResponse.productDetails.isEmpty)
    {
      ManageToastMessage.showShort('[ManageInAppPurchase : initStoreInfo] - productDetailResponse.productDetails.isEmpty');

      //setState(()
      //{
      _queryProductError = null;
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = [];
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = [];
      _purchasePending = false;
      _loading = false;
      //});

      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse = await _connection.queryPastPurchases();
    if (purchaseResponse.error != null)
    {
      ManageToastMessage.showShort('[ManageInAppPurchase : initStoreInfo] - '+purchaseResponse.error.message);
      // handle query past purchase error..
    }

    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases)
    {
      if (await _verifyPurchase(purchase))
      {
        verifiedPurchases.add(purchase);
      }

      _deliverProduct(purchase); // Deliver the purchase to the user in your app.


      if (Platform.isIOS)
      {
        // Mark that you've delivered the purchase. Only the App Store requires
        // this final confirmation.
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
    }


    List<String> consumables = await ConsumableStore.load();

    //setState(()
    //{
    _isAvailable = isAvailable;
    _products = productDetailResponse.productDetails;
    _purchases = verifiedPurchases;
    _notFoundIds = productDetailResponse.notFoundIDs;
    _consumables = consumables;
    _purchasePending = false;
    _loading = false;
    //});
  }


  void dispose()
  {
    if(null != _subscription)
     {
       _subscription.cancel();
       _subscription = null;
     }
  }

  Future<bool> isAvailable() async
  {
    return await InAppPurchaseConnection.instance.isAvailable();
  }


  Future<void> consume(String id) async
  {
    await ConsumableStore.consume(id);

    final List<String> consumables = await ConsumableStore.load();

    //setState(()
    //{
     _consumables = consumables;
    //});
  }

  void showPendingUI()
  {
    //setState(()
    //{
      _purchasePending = true;
    //});
  }

  void _deliverProduct(PurchaseDetails purchaseDetails) async
  {
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.

    bool consumable = true;

    //if (purchaseDetails.productID == _kConsumableId)
    if(true == consumable)
    {
      await ConsumableStore.save(purchaseDetails.purchaseID);
      List<String> consumables = await ConsumableStore.load();

      //setState(()
      //{
      _purchasePending = false;
      _consumables = consumables;
      //});
    }
    else
    {
      //setState(()
      //{
      _purchases.add(purchaseDetails);
      _purchasePending = false;
      //});
    }
  }


  void handleError(IAPError error)
  {
    print('[ManageInAppPurchase : handleError] - error : ${error.message}');
    //error.message

    //setState(()
    //{
    _purchasePending = false;
    //});
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails)
  {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails)
  {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList)
  {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async
    {
      if (purchaseDetails.status == PurchaseStatus.pending)
      {
        showPendingUI();
        if(null != _callbackInAppPurchase)
          _callbackInAppPurchase('pending',true);
      }
      else
      {
        if (purchaseDetails.status == PurchaseStatus.error)
        {
          handleError(purchaseDetails.error);
          if(null != _callbackInAppPurchase)
            _callbackInAppPurchase('error',true);
        }
        else if (purchaseDetails.status == PurchaseStatus.purchased)
        {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid)
          {
            _deliverProduct(purchaseDetails);
          }
          else
          {
            _handleInvalidPurchase(purchaseDetails);
          }

          if(null != _callbackInAppPurchase)
            _callbackInAppPurchase('purchased',true);
        }

        if (Platform.isIOS)
        {
          await InAppPurchaseConnection.instance.completePurchase(purchaseDetails);
        }
        else if (Platform.isAndroid)
        {
          if (!kAutoConsume /* && purchaseDetails.productID == _kConsumableId */)
          {
            await InAppPurchaseConnection.instance.consumePurchase(purchaseDetails);
          }
        }
      }
    });
  }

  bool _isConsumable(ProductDetails productDetails)
  {
    return true;
  }

  void buy(String id)
  {
    ProductDetails productDetails = null; // Saved earlier from queryPastPurchases().
    for(int countIndex= 0; countIndex< _products.length; ++countIndex)
    {
      if(_products[countIndex].id == id)
        {
          productDetails = _products[countIndex];
          break;
        }
    }

    if(null == productDetails)
      return;

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    if (_isConsumable(productDetails))
    {
      InAppPurchaseConnection.instance.buyConsumable(purchaseParam: purchaseParam);
    }
    else
    {
      InAppPurchaseConnection.instance.buyNonConsumable(purchaseParam: purchaseParam);
    }

  }

}


/*
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'consumable_store.dart';

void main() {
  runApp(MyApp());
}

const bool kAutoConsume = true;

const String _kConsumableId = 'consumable';
const List<String> _kProductIds = <String>[
  _kConsumableId,
  'upgrade',
  'subscription'
];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = [];
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  List<String> _consumables = [];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String _queryProductError;

  @override
  void initState() {
    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      // handle error here.
    });
    initStoreInfo();
    super.initState();
  }

  Future<void> initStoreInfo() async {
    final bool isAvailable = await _connection.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = [];
        _purchases = [];
        _notFoundIds = [];
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    ProductDetailsResponse productDetailResponse =
        await _connection.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = [];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _consumables = [];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    final QueryPurchaseDetailsResponse purchaseResponse =
        await _connection.queryPastPurchases();
    if (purchaseResponse.error != null) {
      // handle query past purchase error..
    }
    final List<PurchaseDetails> verifiedPurchases = [];
    for (PurchaseDetails purchase in purchaseResponse.pastPurchases) {
      if (await _verifyPurchase(purchase)) {
        verifiedPurchases.add(purchase);
      }
    }
    List<String> consumables = await ConsumableStore.load();
    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _purchases = verifiedPurchases;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _consumables = consumables;
      _purchasePending = false;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];
    if (_queryProductError == null) {
      stack.add(
        ListView(
          children: [
            _buildConnectionCheckTile(),
            _buildProductList(),
            _buildConsumableBox(),
          ],
        ),
      );
    } else {
      stack.add(Center(
        child: Text(_queryProductError),
      ));
    }
    if (_purchasePending) {
      stack.add(
        Stack(
          children: [
            Opacity(
              opacity: 0.3,
              child: const ModalBarrier(dismissible: false, color: Colors.grey),
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('IAP Example'),
        ),
        body: Stack(
          children: stack,
        ),
      ),
    );
  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return Card(child: ListTile(title: const Text('Trying to connect...')));
    }
    final Widget storeHeader = ListTile(
      leading: Icon(_isAvailable ? Icons.check : Icons.block,
          color: _isAvailable ? Colors.green : ThemeData.light().errorColor),
      title: Text(
          'The store is ' + (_isAvailable ? 'available' : 'unavailable') + '.'),
    );
    final List<Widget> children = <Widget>[storeHeader];

    if (!_isAvailable) {
      children.addAll([
        Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  Card _buildProductList() {
    if (_loading) {
      return Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching products...'))));
    }
    if (!_isAvailable) {
      return Card();
    }
    final ListTile productHeader = ListTile(
        title: Text('Products for Sale',
            style: Theme.of(context).textTheme.headline));
    List<ListTile> productList = <ListTile>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().errorColor)),
          subtitle: Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));
    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verity the purchase data.
    Map<String, PurchaseDetails> purchases =
        Map.fromEntries(_purchases.map((PurchaseDetails purchase) {
      if (Platform.isIOS) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
    productList.addAll(_products.map(
      (ProductDetails productDetails) {
        PurchaseDetails previousPurchase = purchases[productDetails.id];
        return ListTile(
            title: Text(
              productDetails.title,
            ),
            subtitle: Text(
              productDetails.description,
            ),
            trailing: previousPurchase != null
                ? Icon(Icons.check)
                : FlatButton(
                    child: Text(productDetails.price),
                    color: Colors.green[800],
                    textColor: Colors.white,
                    onPressed: () {
                      PurchaseParam purchaseParam = PurchaseParam(
                          productDetails: productDetails,
                          applicationUserName: null,
                          sandboxTesting: true);
                      if (productDetails.id == _kConsumableId) {
                        _connection.buyConsumable(
                            purchaseParam: purchaseParam,
                            autoConsume: kAutoConsume || Platform.isIOS);
                      } else {
                        _connection.buyNonConsumable(
                            purchaseParam: purchaseParam);
                      }
                    },
                  ));
      },
    ));

    return Card(
        child:
            Column(children: <Widget>[productHeader, Divider()] + productList));
  }

  Card _buildConsumableBox() {
    if (_loading) {
      return Card(
          child: (ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching consumables...'))));
    }
    if (!_isAvailable || _notFoundIds.contains(_kConsumableId)) {
      return Card();
    }
    final ListTile consumableHeader = ListTile(
        title: Text('Purchased consumables',
            style: Theme.of(context).textTheme.headline));
    final List<Widget> tokens = _consumables.map((String id) {
      return GridTile(
        child: IconButton(
          icon: Icon(
            Icons.stars,
            size: 42.0,
            color: Colors.orange,
          ),
          splashColor: Colors.yellowAccent,
          onPressed: () => consume(id),
        ),
      );
    }).toList();
    return Card(
        child: Column(children: <Widget>[
      consumableHeader,
      Divider(),
      GridView.count(
        crossAxisCount: 5,
        children: tokens,
        shrinkWrap: true,
        padding: EdgeInsets.all(16.0),
      )
    ]));
  }

  Future<void> consume(String id) async {
    await ConsumableStore.consume(id);
    final List<String> consumables = await ConsumableStore.load();
    setState(() {
      _consumables = consumables;
    });
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  void deliverProduct(PurchaseDetails purchaseDetails) async {
    // IMPORTANT!! Always verify a purchase purchase details before delivering the product.
    if (purchaseDetails.productID == _kConsumableId) {
      await ConsumableStore.save(purchaseDetails.purchaseID);
      List<String> consumables = await ConsumableStore.load();
      setState(() {
        _purchasePending = false;
        _consumables = consumables;
      });
    } else {
      setState(() {
        _purchases.add(purchaseDetails);
        _purchasePending = false;
      });
    }
  }

  void handleError(IAPError error) {
    setState(() {
      _purchasePending = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  static ListTile buildListCard(ListTile innerTile) =>
      ListTile(title: Card(child: innerTile));

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
          }
        }
        if (Platform.isIOS) {
          await InAppPurchaseConnection.instance
              .completePurchase(purchaseDetails);
        } else if (Platform.isAndroid) {
          if (!kAutoConsume && purchaseDetails.productID == _kConsumableId) {
            await InAppPurchaseConnection.instance
                .consumePurchase(purchaseDetails);
          }
        }
      }
    });
  }
}
 */