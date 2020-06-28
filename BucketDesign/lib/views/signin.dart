// Packages
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  static const routeName = "/signin";
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text("Sign In"),
        ],
      ),
    );
  }
}
