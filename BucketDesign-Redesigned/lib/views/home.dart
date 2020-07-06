// Packages
import 'package:flutter/material.dart';

// Widgets
import '../widgets/customNavigationBar.dart';
import '../widgets/custom_icons_icons.dart';
import '../widgets/home_widget.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> items = [
    {
      "icon": CustomIcons.home_smile_icon,
      "index": 0,
      "widget": HomeWidget(),
    },
    {
      "icon": CustomIcons.chat_smile_icon,
      "index": 1,
      "widget": Center(child: Text("Messages")),
    },
    {
      "icon": CustomIcons.search_eye_icon,
      "index": 2,
      "widget": Center(child: Text("Search")),
    },
  ];
  int _tapped = 0;

  void viewSelector(int index) {
    setState(() {
      _tapped = index;
    });
  }

  void changeViewFromPan(DragEndDetails details) {
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
    MediaQueryData mq = MediaQuery.of(context);

    return Scaffold(
      body: GestureDetector(
        onPanEnd: (details) => changeViewFromPan(details),
        child: Container(
          margin: EdgeInsets.only(top: mq.padding.top),
          width: mq.size.width,
          height: mq.size.height,
          color: Theme.of(context).backgroundColor,
          child: items[_tapped]["widget"],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        tapped: _tapped,
        callback: viewSelector,
        items: items,
      ),
      floatingActionButton: GestureDetector(
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          curve: Curves.easeInExpo,
          width: 65,
          height: 65,
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
