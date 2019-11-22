
import 'package:cloud_firestore/cloud_firestore.dart';


class ManageFireBaseCloudFireStore
{
  static final reference = Firestore.instance;
  static Future<DocumentSnapshot> getDocumentSnapshot(String collectionId,String documentId) async
  {
    // await reference.collection(ModelComicInfo.ModelName).document(modelFeaturedComicInfo.comicId).get()
    return await reference.collection(collectionId).document(documentId).get();
  }

  static Future<QuerySnapshot> getQuerySnapshot(String collectionId) async
  {
    return await reference.collection(collectionId).getDocuments();
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////

  static void createRecord() async
  {
    await reference.collection("books")
        .document("1")
        .setData({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await reference.collection("books")
        .add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);
  }

  static void getData() {
    reference
        .collection("model_preset")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  static void updateData()
  {
    try {
      reference
          .collection('books')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }


  static void updateData2()
  {
    print('updateData2');

    try{
     reference.collection('model_user_info')
        .document('BmmwNKFniiet5LeRS2GhK1oTeUw1').collection('creators').document('BmmwNKFniiet5LeRS2GhK1oTeUw1creator111111111')
        .setData({
      'create_time':'22222',
    }).
    then((_) {
       print('=======================================>');

    });
    }
    catch (e) {
      print('=======================================> ${e.toString()}');
    }

  }


  static void deleteData2() {
    try {
      reference
          .collection('model_user_info')
          .document('BmmwNKFniiet5LeRS2GhK1oTeUw1').collection('creators').document('BmmwNKFniiet5LeRS2GhK1oTeUw1creator1573526700381')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }


  static void deleteData() {
    try {
      reference
          .collection('model_user_info')
          .document('BmmwNKFniiet5LeRS2GhK1oTeUw1')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

}