// Packages
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Utils
import '../../utils/Theme.dart';

// Widgets
import '../../utils/roundRect.dart';

class HastagCard extends StatelessWidget {
  final String title;
  final int color;

  HastagCard(this.color, this.title);

  final List<Color> _colors = const [
    Color.fromRGBO(46, 192, 249, 1.0),
    Color.fromRGBO(249, 47, 217, 1.0),
    Color.fromRGBO(208, 248, 101, 1.0)
  ];

  final List<Color> _shadow = const [
    Color.fromRGBO(46, 192, 249, 0.5),
    Color.fromRGBO(249, 47, 217, 0.5),
    Color.fromRGBO(208, 248, 101, 0.5)
  ];

  final List<Color> _darker = const [
    Color(0xff04688F),
    Color(0xFFF99AED),
    Color(0xFFF9B32C)
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("helo"),
      child: RoundedRect(
        radius: 20,
        width: 200,
        height: 250,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(25),
        gradient: LinearGradient(
          colors: [
            _colors[color],
            _darker[color]
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
        ),
        shadow: [
          BoxShadow(
            blurRadius: 15.0,
            color: _shadow[color],
            offset: Offset.fromDirection(0, 0)
          )
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: CustomTheme().white,
                fontSize: CustomTheme().titleSize,
                fontWeight: FontWeight.bold
              )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Icon(
                          FontAwesomeIcons.users,
                          color: CustomTheme().white,
                          size: 30.0,
                        ),
                      ),
                      Text(
                        "100K",
                        style: TextStyle(
                          color: CustomTheme().white,
                          fontSize: CustomTheme().subtitleSize,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Icon(
                          FontAwesomeIcons.tint,
                          color: CustomTheme().white,
                          size: 30.0,
                        ),
                      ),
                      Text(
                        "432K",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: CustomTheme().subtitleSize,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  )
                ),
              ],
            )
          ],
        )
      )
    );
  }
}