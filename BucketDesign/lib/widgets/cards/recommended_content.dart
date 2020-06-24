// Packages
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Utils
import '../../utils/Theme.dart';

class Content extends StatelessWidget {
  final int index;
  final String author, profession;

  Content(this.index, this.author, this.profession);

  final List<String> _icons = [
    "assets/user/kyros.svg",
    "assets/user/mds.svg",
    "assets/user/morgan.svg",
  ];

  final List<Color> _colors = const [
    Color.fromRGBO(46, 192, 249, 1.0),
    Color.fromRGBO(249, 47, 217, 1.0),
    Color.fromRGBO(208, 248, 101, 1.0)
  ];

  final List<Color> _lighter = const [
    Color.fromRGBO(46, 192, 249, .4),
    Color.fromRGBO(249, 47, 217, .4),
    Color.fromRGBO(208, 248, 101, .4)
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
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: _colors[index],
            boxShadow: [
              BoxShadow(
                blurRadius: 15.0,
                color: _shadow[index],
                offset: Offset.fromDirection(0, 0),
              ),
            ],
          ),
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(30),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            image: DecorationImage(
              alignment: Alignment.centerRight,
              fit: BoxFit.contain,
              image: AssetImage("assets/images/ui.png"),
            ),
          ),
          margin: EdgeInsets.only(right: 0),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              colors: [_lighter[index], _darker[index]],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 60,
                height: 60,
                child: SvgPicture.asset(_icons[index]),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    profession,
                    style: TextStyle(
                      color: CustomTheme.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    author,
                    style: TextStyle(
                      color: CustomTheme.white,
                      fontWeight: FontWeight.bold,
                      fontSize: CustomTheme.cardAuthorSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
