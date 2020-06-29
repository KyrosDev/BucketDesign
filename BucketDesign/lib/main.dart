// Packages
import 'package:flutter/material.dart';

// Views
import './helper/authenticate.dart';
import './views/home.dart';
import 'settings/views/settings.dart';
import './views/postDetails.dart';
import './views/fullPhoto.dart';
import './views/user_chat.dart';

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
      debugShowCheckedModeBanner: false,
      title: "Bucket Design",
      theme: ThemeData(
        fontFamily: "Sailec",
        canvasColor: Colors.transparent,
      ),
      routes: {
        "/": (context) => Authenticate(),
        Home.routeName: (context) => Home(),
        Settings.routeName: (context) => Settings(),
        PostPage.routeName: (context) => PostPage(),
        FullImageViewer.routeName: (context) => FullImageViewer(),
        UserChat.routeName: (context) => UserChat(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => Scaffold(
            body: Center(
              child: Text(
                'Not Found\n go back',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
