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
  List<Map<String, Object>> _pages;
  int _page = 0;
  bool profile = false;

  @override
  void initState() {
    _pages = [
      {
        "page": MainPage(),
        "title": "Home",
      },
      {
        "page": SearchView(),
        "title": "Search",
      },
      {
        "page": ChatView(),
        "title": "Chat",
      },
      {
        "page": UploadView(),
        "title": "Upload",
      }
    ];
    super.initState();
  }

  void _selectPage(int i) {
    setState(() {
      if (profile) profile = false;
      _page = i;
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
        body: profile ? ProfileView() : _pages[_page]["page"],
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
                onTap: (page) => _selectPage(page),
                backgroundColor: CustomTheme().darkGray,
                type: BottomNavigationBarType.fixed,
                currentIndex: _page,
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
