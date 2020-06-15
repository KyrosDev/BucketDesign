// Packages
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Utils
import '../utils/Theme.dart';
import '../utils/Designer.dart';
import '../utils/roundRect.dart';

class SearchResult extends StatefulWidget {
  final String res;
  final String shortcode;

  SearchResult(this.res, this.shortcode);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final List<Designer> designers = [
    Designer(
      username: "Kyros Design",
      id: DateTime.now().toString(),
      followers: 234,
      follows: 20,
      likes: 257,
      images: 34,
      profession: "UI Designer",
      professionShortcode: "ui_design",
      color: Colors.red,
    ),
    Designer(
      username: "Media Design",
      id: DateTime.now().toString(),
      followers: 234,
      follows: 20,
      likes: 257,
      images: 34,
      profession: "Industrial Product Designer",
      professionShortcode: "industrial_product_design",
      color: Colors.orange,
    ),
    Designer(
      username: "Mark",
      id: DateTime.now().toString(),
      followers: 234,
      follows: 20,
      likes: 257,
      images: 34,
      profession: "Graphic Designer",
      professionShortcode: "graphic_design",
      color: Colors.blue,
    ),
    Designer(
      username: "Giorgio Des",
      id: DateTime.now().toString(),
      followers: 234,
      follows: 20,
      likes: 257,
      images: 34,
      profession: "Motion Designer",
      professionShortcode: "motion_design",
      color: Colors.brown,
    ),
    Designer(
      username: "Franco Martinez",
      id: DateTime.now().toString(),
      followers: 234,
      follows: 20,
      likes: 257,
      images: 34,
      profession: "Animation Graphic Designer",
      professionShortcode: "animation_graphic_design",
      color: Colors.green,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: "Results",
                ),
                TextSpan(
                  text: ".",
                  style: TextStyle(
                    color: Color.fromRGBO(46, 192, 249, 1.0),
                  ),
                ),
              ],
            ),
          ),
          ...designers.where((element) {
            if (widget.shortcode != "") {
              return element.professionShortcode.contains(widget.shortcode);
            } else {
              return element.username.toLowerCase().contains(widget.res);
            }
          }).map((user) {
            return GestureDetector(
              onTap: () => print(user.username),
                child: RoundedRect(
                radius: 10,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                height: 100,
                color: Color.fromRGBO(29, 29, 29, 1),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    RoundedRect(
                      radius: 10,
                      color: user.color,
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(right: 20),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: SvgPicture.asset("assets/user/kyros.svg"),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.profession,
                          style: TextStyle(
                              color: CustomTheme().white, fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          user.username,
                          style: TextStyle(
                            color: CustomTheme().white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
