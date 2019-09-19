
import 'package:firebase_database/firebase_database.dart';





class ManageFirebaseDatabase
{

  static final DatabaseReference reference = FirebaseDatabase.instance.reference();



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



}