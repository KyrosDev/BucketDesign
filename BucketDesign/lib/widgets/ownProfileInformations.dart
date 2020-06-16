// Packages
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Utils
import '../utils/Theme.dart';

// Widgets
import '../widgets/profileCounters.dart';

class OwnProfileInformations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 70,
          height: 70,
          child: SvgPicture.asset("assets/user/kyros.svg"),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              Text(
                "Kyros Design",
                style: TextStyle(
                  color: CustomTheme().white,
                  fontSize: CustomTheme().titleSize,
                ),
              ),
              Text(
                "UI Designer",
                style: TextStyle(
                    color: CustomTheme().gray,
                    fontSize: 18,
                    fontWeight: FontWeight.w100),
              ),
              Container(
                width: 250,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "📱 The app for every Digital Designer. Create 🎨, Share 🗣️ and have fun with Designers 👩‍🎨 from all the world 🌐.",
                      style: TextStyle(
                        color: CustomTheme().gray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ProfileCounters(
                      followersCounter: 342,
                      postsCounter: 263,
                      likesCounter: 642,
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: "Sailec",
                    color: CustomTheme().white,
                    fontSize: CustomTheme().titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "Posts",
                    ),
                    TextSpan(
                      text: ".",
                      style: TextStyle(
                        color: CustomTheme().mainColor,
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
