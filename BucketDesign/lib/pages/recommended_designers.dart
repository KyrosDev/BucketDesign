// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

// Widgets
import './cards/recommended.dart';

class RecommendedDesigners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          margin: EdgeInsets.all(20),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: CustomTheme().white,
                fontSize: 35,
                fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(
                  text: "Recommended\nDesigners"
                ),
                TextSpan(
                  text: ".",
                  style: TextStyle(
                    color: CustomTheme().mainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        RecommendedCard(0, "Kyros Design", "UI Designer"),
        RecommendedCard(1, "Media Design", "Industrial Product Design"),
        RecommendedCard(2, "Karl", "Web Designer"),
      ]
    );
  }
}