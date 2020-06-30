// Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Models
import '../models/Designer.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TestDesigner _designerFromFirebaseDesigner(FirebaseUser designer) {
    return designer != null ? TestDesigner(designer.uid) : null;
  }

  // LOGIN AUTHENTICATION
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser firebaseDesigner = result.user;
      return _designerFromFirebaseDesigner(firebaseDesigner);
    } catch (err) {
      if (err is PlatformException) {
        if (err.code == "ERROR_USER_NOT_FOUND") {
          return {"error": "User doesn't found. Try again."};
        } else if (err.code == "ERROR_WRONG_PASSWORD") {
          return {"error": "The password is invalid. Try again."};
        } else {
          print("$err, ${err.code}");
        }
      }
    }
  }

  // REGISTER AUTHENTICATION
  Future signUpWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser firebaseDesigner = result.user;
      return _designerFromFirebaseDesigner(firebaseDesigner);
    } catch (signUpError) {
      dynamic snap = await Firestore.instance
          .collection("designers")
          .where("name", isEqualTo: username)
          .getDocuments();
      print(snap);
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return {"error": "Email already in use. Try Again."};
        }
      }
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toSTring());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
