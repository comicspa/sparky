
import 'package:firebase_database/firebase_database.dart';


// https://cionman.tistory.com/72
// https://www.slideshare.net/sungbeenjang/firebase-for-web-3-realtime-database
// http://blog.naver.com/PostView.nhn?blogId=wj8606&logNo=221204979652&parentCategoryNo=&categoryNo=10&viewDate=&isShowPopularPosts=true&from=search
// https://stackoverflow.com/questions/26700924/query-based-on-multiple-where-clauses-in-firebase
// https://polyglot-programming.tistory.com/26
// https://stack07142.tistory.com/282
// http://blog.naver.com/PostView.nhn?blogId=wj8606&logNo=221204979652&parentCategoryNo=&categoryNo=10&viewDate=&isShowPopularPosts=true&from=search
// https://grokonez.com/flutter/flutter-firebase-database-example-firebase-database-crud-listview
// https://dart.academy/build-a-real-time-chat-web-app-with-dart-angular-2-and-firebase-3/
// https://beomseok95.tistory.com/114?category=1031942
// https://medium.com/flutter-community/building-a-chat-app-with-flutter-and-firebase-from-scratch-9eaa7f41782e
// https://academy.realm.io/kr/posts/firebase-as-a-real-mobile-backend/
// https://forest71.tistory.com/170
// https://github.com/firebase/functions-samples/blob/master/convert-images/functions/index.js

class ManageFirebaseDatabase
{
  static final DatabaseReference reference = FirebaseDatabase.instance.reference();

  /*
  static Future<void> dddd() async
  {
    reference.child('.info/connected').on.on('value', function(connectedSnap) {
    if (connectedSnap.val() ==true) {
    /* we're connected! */
    } else {
    /* we're disconnected! */
    }
    });
  }
   */


  static Future<Map<dynamic,dynamic>> read(String childName) async
  {
    DatabaseReference modelUserInfoReference = reference.child(childName);
    modelUserInfoReference.once().then((DataSnapshot snapshot)
    {
      print('read sample : ${snapshot.value}');
      return snapshot.value;

    });

    return null;

  }


  static String readOrderByChild(String childName,String orderByChild,String equalTo)
  {
    DatabaseReference modelUserInfoReference = reference.child(childName);
    modelUserInfoReference.orderByChild(orderByChild).equalTo(equalTo).once().then((DataSnapshot snapshot)
    {
      print('read sample : ${snapshot.value}');
      return snapshot.value;
    });

    return '';
  }


  static void create()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_user_info');
    modelUserInfoReference.child('6666').set({
   // modelUserInfoReference.push().set({
      'id': '1111',
      'creator_id': '22222'
    }).then((_) {
      // ...
    });

    //print('create - key : ${modelUserInfoReference.key}');
  }


  static void update()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_user_info');

    //print('update - key : ${modelUserInfoReference.key}');


    modelUserInfoReference.set({
      'id': '2222',
      'creator_id': '55555'
    }).then((_) {
      // ...
    });
  }


  static void delete()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_user_info');
    modelUserInfoReference.remove().then((_) {
      // ...
    });
  }


  static void testRead()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_user_info');
    modelUserInfoReference.orderByChild('id').equalTo('1111').once().then((DataSnapshot snapshot)
    {
        //{6666: {id: 1111, creator_id: 22222}}
        print('read sample : ${snapshot.value}');

    });
  }


  static void set()
  {
    DatabaseReference modelUserInfoReference = reference.child('model_weekly_creator_info');

    modelUserInfoReference.child('1566811403000_000001').set({
      'comic_id': '000001',
      'creator_id': '1566811403000',
      'creator_name': '묵검향',
      'title':'아비향',
      'user_id':'1566811403000',
    }).then((_) {
      // ...
    });

    modelUserInfoReference.child('1566811403000_000002').set({
      'comic_id': '000002',
      'creator_id': '1566811403000',
      'creator_name': '묵검향',
      'title':'반야',
      'user_id':'1566811403000',
    }).then((_) {
      // ...
    });

    modelUserInfoReference.child('1566811403000_000003').set({
      'comic_id': '000003',
      'creator_id': '1566811403000',
      'creator_name': '묵검향',
      'title':'개구쟁이',
      'user_id':'1566811403000',
    }).then((_) {
      // ...
    });

    modelUserInfoReference.child('1566811443000_000001').set({
      'comic_id': '000001',
      'creator_id': '1566811443000',
      'creator_name': 'sample',
      'title':'sample',
      'user_id':'1566811443000',
    }).then((_) {
      // ...
    });



  }


}