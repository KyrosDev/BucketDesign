// Packages
import 'package:cloud_firestore/cloud_firestore.dart';

class DBMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("designers")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  uploadUserInfo(Map<String, String> designer) {
    Firestore.instance
        .collection("designers")
        .add(designer)
        .then((e) => print("Registred Succesuly. $e"))
        .catchError((e) => print(e.toString()));
  }
}
