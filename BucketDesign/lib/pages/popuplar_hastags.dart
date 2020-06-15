// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

// Widgets
import './cards/hastag.dart';

class HastagsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 2,
          margin: EdgeInsets.all(20),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: CustomTheme().white,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
              children: [
                TextSpan(
                  text: "Popular\n",
                ),
                TextSpan(
                  text: "#",
                  style: TextStyle(
                    color: CustomTheme().mainColor,
                  ),
                ),
                TextSpan(
                  text: "Hastags",
                ),
                TextSpan(
                  text: ".",
                  style: TextStyle(
                    color: CustomTheme().mainColor,
                    fontSize: CustomTheme().titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              HastagCard(0, "Graphic Design"),
              HastagCard(1, "UI/UX Design"),
              HastagCard(2, "Industrial Design"),
            ],
          )
        )
      ],
    );
  }
}