// Packages
import 'package:cloud_firestore/cloud_firestore.dart';

class DBMethods {
  getUserByUsername(String username) async {
    return Firestore.instance
        .collection("designers")
        .where("username", isEqualTo: username)
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

  sendMessage(String chatroomId, Map<String, dynamic> message) async {
    return await Firestore.instance
        .collection("chatrooms")
        .document(chatroomId)
        .collection("chats")
        .add(message)
        .catchError((e) => print(e.toString()));
  }

  createRoom(String chatRoomId, Map<String, dynamic> chatRoomMap) {
    Firestore.instance
        .collection("chatrooms")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) => print(e.toString()));
  }

  getMessages(String chatroomId) async {
    return await Firestore.instance
        .collection("chatrooms")
        .document(chatroomId)
        .collection("chats")
        .orderBy("date", descending: false)
        .snapshots();
  }
}
