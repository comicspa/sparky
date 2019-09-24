
import 'package:firebase_database/firebase_database.dart';





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
    DatabaseReference modelUserInfoReference = reference.child('model_view_comic_info');

    modelUserInfoReference.child('1566811443000_000001_00001').set({
      'count': '1',
      'style': '0',
      'title': 'sample1',
    }).then((_) {
      // ...
    });

    modelUserInfoReference.child('1566811443000_000001_00002').set({
      'count': '6',
      'style': '0',
      'title': 'sample2',
    }).then((_) {
      // ...
    });

    modelUserInfoReference.child('1566811443000_000001_00003').set({
      'count': '5',
      'style': '0',
      'title': 'sample3',
    }).then((_) {
      // ...
    });

    modelUserInfoReference.child('1566811443000_000001_00004').set({
      'count': '5',
      'style': '0',
      'title': 'sample4',
    }).then((_) {
      // ...
    });


    modelUserInfoReference.child('1566811443000_000001_00005').set({
      'count': '6',
      'style': '0',
      'title': 'sample5',
    }).then((_) {
      // ...
    });


    modelUserInfoReference.child('1566811443000_000001_00006').set({
      'count': '8',
      'style': '0',
      'title': 'sample6',
    }).then((_) {
      // ...
    });







  }


}