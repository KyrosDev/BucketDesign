// Packages
import 'package:flutter/material.dart';

class TagsListView extends StatelessWidget {

  final List<Map> tags = [
    {
      "text": "UI Design",
      "color": 0xFF2EC0F9,
    },
    {
      "text": "Web Design",
      "color": 0xFFF9C02E,
    },
    {
      "text": "Product Design",
      "color": 0xFF23CB48,
    },
    {
      "text": "Motion Design",
      "color": 0xFFC04040,
    },
    {
      "text": "Graphic Design",
      "color": 0xFF9F40C0,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          ...(tags).map((e) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: GestureDetector(
                onTap: () => print(e["text"]),
                child: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(e["color"]),
                ),
                child:  Text(
                  e["text"],
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