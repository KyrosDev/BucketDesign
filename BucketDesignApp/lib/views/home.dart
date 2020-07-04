// Packages
import 'package:flutter/material.dart';

// Widgets
import '../widgets/customNavigationBar.dart';
import '../widgets/custom_icons_icons.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> items = [
    {"icon": CustomIcons.home_smile_icon, "index": 0, "text": "Home"},
    {"icon": CustomIcons.chat_smile_icon, "index": 1, "text": "Messages"},
    {"icon": CustomIcons.search_eye_icon, "index": 2, "text": "Search"},
  ];
  int _tapped = 0;

  void viewSelector(int index) {
    setState(() {
      _tapped = index;
    });
  }

  void changeViewFromPan(DragEndDetails details) {
    print(details.velocity.pixelsPerSecond.dx);
    if (details.velocity.pixelsPerSecond.dx < 200) {
      setState(() {
        if (_tapped == items.length - 1) return;
        _tapped++;
      });
    }
    if (details.velocity.pixelsPerSecond.dx > -200) {
      setState(() {
        _tapped = _tapped != 0 ? _tapped - 1 : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanEnd: (details) => changeViewFromPan(details),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Text(
              items[_tapped]["text"],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        tapped: _tapped,
        callback: viewSelector,
        items: items,
      ),
      floatingActionButton: GestureDetector(
        onTap: () => print("tapped, sos"),
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInExpo,
          width: 70,
          height: 70,
          margin: const EdgeInsets.only(
            right: 10,
            top: 30,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(23),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0xFF04688F).withOpacity(0.4),
                offset: Offset(0, 20),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
            gradient: LinearGradient(
              colors: [
                Color(0xFF2EC0F9),
                Color(0xFF04688F),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
