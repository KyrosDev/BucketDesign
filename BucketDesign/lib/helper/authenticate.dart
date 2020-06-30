// Packages
import 'package:flutter/material.dart';

// Views
import '../views/signin.dart';
import '../views/signup.dart';

class Authenticate extends StatefulWidget {
  static const routeName = "/authenticate";

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showSignIn = true;

  void toggleView() {
    setState(() {
      _showSignIn = !_showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSignIn) {
      return SignIn(toggleView);
    } else {
      return SignUp(callback: toggleView);
    }
  }
}
