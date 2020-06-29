// Packages
import 'package:firebase_auth/firebase_auth.dart';

// Models
import '../models/Designer.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TestDesigner _designerFromFirebaseDesigner(FirebaseUser designer) {
    return designer != null ? TestDesigner(designer.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser firebaseDesigner = result.user;
      return _designerFromFirebaseDesigner(firebaseDesigner);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseDesigner = result.user;
      return _designerFromFirebaseDesigner(firebaseDesigner);
    } catch (e) {
      print(e.toString());
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
