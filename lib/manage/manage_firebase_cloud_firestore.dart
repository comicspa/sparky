
import 'package:cloud_firestore/cloud_firestore.dart';


class ManageFireBaseCloudFireStore
{

  static final reference = Firestore.instance;


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


  static void deleteData() {
    try {
      reference
          .collection('books')
          .document('1')
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

}