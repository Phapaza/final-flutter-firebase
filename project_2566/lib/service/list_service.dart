import 'package:cloud_firestore/cloud_firestore.dart';

class ListService {
  Future<void> addLsit2Firebase(String documentid, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection("list")
        .doc(documentid)
        .set(data)        
        .then((value) {
      print("List created");
    }).catchError((error) {
      print("Can't list item:" + error.toString());
    });
  }

  Future<void> editList(String documentid, Map<String, String> data) {
    return FirebaseFirestore.instance
        .collection("list")
        .doc(documentid)
        .update(data)
        .then((value) {
      print("List updated");
    }).catchError((error) {
      print("Can't update list:" + error.toString());
    });
  }

  Future<void> deleteList(String documentid) {
    return FirebaseFirestore.instance
        .collection("list")
        .doc(documentid)
        .delete()
        .then((value) {
      print("List deleted");
    }).catchError((error) {
      print("Can't delete list:" + error.toString());
    });
  }
}
