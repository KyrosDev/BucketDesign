// Packages
import 'package:BucketDesign/views/initial_loading.dart';
import 'package:flutter/material.dart';

// Views
import './helper/authenticate.dart';
import './views/home.dart';
import './settings/views/settings.dart';
import './views/postDetails.dart';
import './views/fullPhoto.dart';

// Helper
import './helper/helperFunctions.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  int index;
  List<Map<String, dynamic>> routes = [
    {
      "path": Home.routeName,
    },
    {
      "path": Authenticate.routeName,
    },
  ];

  @override
  void initState() {
    getLoggedInState();
    setState(() {});
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
      setState(() {
        if (userIsLoggedIn == true && value == true)
          index = 0;
        else
          index = 1;
      });
      print(userIsLoggedIn);
    }).catchError((e) => print(e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bucket Design",
      theme: ThemeData(
        fontFamily: "Sailec",
        canvasColor: Colors.transparent,
      ),
      initialRoute: routes[index]["path"],
      routes: {
        Loading.routeName: (context) => Loading(),
        Home.routeName: (context) => Home(),
        Authenticate.routeName: (context) => Authenticate(),
        Settings.routeName: (context) => Settings(),
        PostPage.routeName: (context) => PostPage(),
        FullImageViewer.routeName: (context) => FullImageViewer(),
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
