// Packages
import 'package:flutter/material.dart';

// Utils
import './utils/Theme.dart';

// Widgets
import './views/main.dart';
import './views/search.dart';
import './views/upload.dart';
import './views/chat.dart';
import './views/profile.dart';
import './widgets/mainAppBar.dart';
import './widgets/profileAppBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool isVisible = false;
  int viewIndex = 0;
  bool profile = false;

  void rotate() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void changeView(i) {
    setState(() {
      if (profile) profile = false;
      viewIndex = i;
    });
  }

  void viewProfile() {
    setState(() {
      profile = !profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bucket Design",
      theme: ThemeData(
        fontFamily: "Sailec",
        canvasColor: Colors.transparent,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          child: !profile
              ? MainAppBar(viewProfile, profile)
              : ProfileAppBar(viewProfile),
          preferredSize: new Size(double.infinity, 60.0),
        ),
        backgroundColor: CustomTheme().darkGray,
        body: profile
            ? ProfileView()
            : !profile && viewIndex == 0
                ? MainPage()
                : viewIndex == 1
                    ? SearchView()
                    : viewIndex == 2
                        ? ChatView()
                        : viewIndex == 3 ? UploadView() : null,
        floatingActionButton: profile ? null : FloatingActionButton(
          onPressed: () {},
          tooltip: "Upload an image",
          child: Icon(
            Icons.add,
            color: CustomTheme().white,
            size: 30,
          ),
        ),
        bottomNavigationBar: profile
            ? null
            : BottomNavigationBar(
                selectedItemColor: CustomTheme().mainColor,
                unselectedItemColor: Colors.white,
                onTap: (index) => changeView(index),
                backgroundColor: CustomTheme().darkGray,
                type: BottomNavigationBarType.fixed,
                currentIndex: viewIndex,
                selectedLabelStyle: TextStyle(fontSize: 15),
                unselectedFontSize: 15,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    title: Text(
                      "Home",
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                    ),
                    title: Text(
                      "Search",
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat,
                    ),
                    title: Text(
                      "Chat",
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.more,
                    ),
                    title: Text(
                      "More",
                    ),
                  ),
                ],
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
