// Package
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

class ProfileAppBar extends StatefulWidget {
  final Function navigatorBack;

  ProfileAppBar(this.navigatorBack);

  @override
  _ProfileAppBarState createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: widget.navigatorBack,
              child: Icon(
                Icons.arrow_back_ios,
                color: CustomTheme.white,
              ),
            ),
            Text(
              "Your Profile",
              style: TextStyle(
                color: CustomTheme.white,
                fontSize: 20,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/profile/edit"),
              child: Icon(
                Icons.settings,
                color: CustomTheme.white,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: CustomTheme.darkGray,
      ),
    );
  }
}
