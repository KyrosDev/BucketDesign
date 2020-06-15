// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

// Widgets
import '../utils/roundRect.dart';

class MainAppBar extends StatefulWidget {
  final bool profile;
  final Function callback;

  MainAppBar(this.callback, this.profile);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0
      ),
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icons/icon.png'),
                  fit: BoxFit.contain
                ),
              )
            ),
            GestureDetector(
              onTap: widget.callback,
              child: RoundedRect(
                width: 30,
                height: 30,
                radius: 5,
                color: CustomTheme().white,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: CustomTheme().darkGray,
      ),
    );
  }
}