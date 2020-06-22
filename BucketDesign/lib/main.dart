// Packages
import 'package:flutter/material.dart';

// Views
import './views/home.dart';
import './views/editProfile.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bucket Design",
      theme: ThemeData(
        fontFamily: "Sailec",
        canvasColor: Colors.transparent,
      ),
      routes: {
        "/": (context) => Home(),
        EditProfileView.routeName: (context) => EditProfileView(),
      }
    );
  }
}
