// Packages
import 'package:cloud_firestore/cloud_firestore.dart';

class DBMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("designers")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserByUserEmail(String email) async {
    return await Firestore.instance
        .collection("designers")
        .where("email", isEqualTo: email)
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
