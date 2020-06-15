// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Tags.dart';

class TagsListView extends StatelessWidget {
  final Function _callback;

  TagsListView(this._callback);

  final List<Tag> tags = [
    Tag(
      name: "UI Design",
      shortcode: "ui_design",
      color: Color(0xFF2EC0F9),
      id: DateTime.now().toString(),
    ),
    Tag(
      name: "Web Design",
      shortcode: "web_design",
      color: Color(0xFFF9C02E),
      id: DateTime.now().toString(),
    ),
    Tag(
      name: "Product Design",
      shortcode: "product_design",
      color: Color(0xFF23CB48),
      id: DateTime.now().toString(),
    ),
    Tag(
      name: "Motion Design",
      shortcode: "motion_design",
      color: Color(0xFFC04040),
      id: DateTime.now().toString(),
    ),
    Tag(
      name: "Graphic Design",
      shortcode: "graphic_design",
      color: Color(0xFF9F40C0),
      id: DateTime.now().toString(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          ...(tags).map((t) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: GestureDetector(
                onTap: () {
                  _callback(t.shortcode);
                },
                child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: t.color,
                ),
                child:  Text(
                  t.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}