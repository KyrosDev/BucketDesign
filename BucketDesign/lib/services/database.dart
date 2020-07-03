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
        .document(designer["email"])
        .setData(designer)
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

  getChatRooms(String username) async {
    return await Firestore.instance
        .collection("chatrooms")
        .where("users", arrayContains: username)
        .orderBy("lastTime", descending: true)
        .snapshots();
  }

  getLastMessage(String chatroomId) async {
    return await Firestore.instance
        .collection("chatrooms")
        .document(chatroomId)
        .collection("chats")
        .snapshots()
        .last;
  }

  getChatRoomId(String username) async {
    return await Firestore.instance
        .collection("chatrooms")
        .where("users", arrayContains: username)
        .snapshots();
  }

  updateLastMessage(Map<String, dynamic> mapMessage, String chatroomId) async {
    return await Firestore.instance
        .collection("chatrooms")
        .document(chatroomId)
        .updateData(mapMessage);
  }

  updateUserInformations(Map<String, dynamic> userMap, String email) async {
    return await Firestore.instance
        .collection("designers")
        .document(email)
        .updateData(userMap)
        .catchError((e) => print(e.toString()));
  }
}
