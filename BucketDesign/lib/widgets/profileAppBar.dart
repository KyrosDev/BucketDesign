// Package
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

class ProfileAppBar extends StatelessWidget {
  final Function callback;

  ProfileAppBar(this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20.0
      ),
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.only(left: 30, right: 30, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: callback,
              child: Icon(
                Icons.arrow_back,
                color: CustomTheme().white,
              ),
            ),
            Text(
              "Your Profile",
              style: TextStyle(
                color: CustomTheme().white,
                fontSize: 20
              ),
            ),
            Icon(
              Icons.settings,
              color: CustomTheme().white,
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: CustomTheme().darkGray,
      ),
    );
  }
}