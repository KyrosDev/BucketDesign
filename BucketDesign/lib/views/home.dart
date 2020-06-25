// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

// Views
import './search.dart';
import './upload.dart';
import './chat.dart';
import './profile.dart';

// Widgets
import '../widgets/homeCards.dart';
import '../widgets/mainAppBar.dart';
import '../widgets/profileAppBar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      },
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
    return Scaffold(
      appBar: PreferredSize(
        child: !profile
            ? MainAppBar(viewProfile, profile)
            : ProfileAppBar(viewProfile),
        preferredSize: new Size(double.infinity, 60.0),
      ),
      backgroundColor: CustomTheme.darkGray,
      body: profile ? ProfileView() : _pages[_page]["page"],
      floatingActionButton: profile
          ? null
          : FloatingActionButton(
              onPressed: () {},
              tooltip: "Upload an image",
              child: Icon(
                Icons.add,
                color: CustomTheme.white,
                size: 30,
              ),
            ),
      bottomNavigationBar: profile
          ? null
          : BottomNavigationBar(
              selectedItemColor: CustomTheme.mainColor,
              unselectedItemColor: Colors.white,
              onTap: (page) => _selectPage(page),
              backgroundColor: CustomTheme.darkGray,
              type: BottomNavigationBarType.fixed,
              currentIndex: _page,
              selectedLabelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
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
    );
  }
}
