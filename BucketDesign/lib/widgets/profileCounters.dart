// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/roundRect.dart';
import '../utils/Theme.dart';

class ProfileCounters extends StatelessWidget {
  final int followersCounter;
  final int postsCounter;
  final int likesCounter;


  ProfileCounters({this.followersCounter, this.postsCounter, this.likesCounter});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              child: RoundedRect(
                radius: 15,
                color: CustomTheme.mainColorDarker,
                width: 70,
                height: 70,
                margin: EdgeInsets.only(top: 30, bottom: 10),
                child: Center(
                  child: Icon(
                    Icons.group,
                    size: 40,
                    color: CustomTheme.mainColor,
                  ),
                ),
              ),
            ),
            Text(
              "$followersCounter",
              style: TextStyle(
                color: CustomTheme.white,
                fontSize: CustomTheme.subtitleSize,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: RoundedRect(
                radius: 15,
                color: CustomTheme.mainColorDarker,
                width: 70,
                height: 70,
                margin: EdgeInsets.only(top: 30, bottom: 10),
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 40,
                    color: CustomTheme.mainColor,
                  ),
                ),
              ),
            ),
            Text(
              "$postsCounter",
              style: TextStyle(
                color: CustomTheme.white,
                fontSize: CustomTheme.subtitleSize,
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: RoundedRect(
                radius: 15,
                color: CustomTheme.mainColorDarker,
                width: 70,
                height: 70,
                margin: EdgeInsets.only(top: 30, bottom: 10),
                child: Center(
                  child: Icon(
                    Icons.favorite,
                    size: 40,
                    color: CustomTheme.mainColor,
                  ),
                ),
              ),
            ),
            Text(
              "$likesCounter",
              style: TextStyle(
                color: CustomTheme.white,
                fontSize: CustomTheme.subtitleSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
