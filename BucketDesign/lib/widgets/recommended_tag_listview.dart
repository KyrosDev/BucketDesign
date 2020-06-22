// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';
import '../models/Tags.dart';

class TagsListView extends StatefulWidget {
  final Function _callback;

  TagsListView(this._callback);

  @override
  _TagsListViewState createState() => _TagsListViewState();
}

class _TagsListViewState extends State<TagsListView> {
  final List<Tag> tags = [
    Tag(
      name: "UI Design",
      shortcode: "ui_design",
      color: Color(0xFF2EC0F9),
      id: DateTime.now().toString(),
      tapped: false,
    ),
    Tag(
      name: "Web Design",
      shortcode: "web_design",
      color: Color(0xFFF9C02E),
      id: DateTime.now().toString(),
      tapped: false,
    ),
    Tag(
      name: "Product Design",
      shortcode: "product_design",
      color: Color(0xFF23CB48),
      id: DateTime.now().toString(),
      tapped: false,
    ),
    Tag(
      name: "Motion Design",
      shortcode: "motion_design",
      color: Color(0xFFC04040),
      id: DateTime.now().toString(),
      tapped: false,
    ),
    Tag(
      name: "Graphic Design",
      shortcode: "graphic_design",
      color: Color(0xFF9F40C0),
      id: DateTime.now().toString(),
      tapped: false,
    )
  ];

  void _bindTapped(Tag t) {
    for (int i = 0; i < tags.length; i++) {
      if (tags[i] != t) {
        setState(() {
          tags[i].tapped = false;
        });
      } else {
        setState(() {
          t.tapped = true;
        });
      }
    }
  }

  void _removeBind(Tag i) {
    setState(() {
      i.tapped = false;
    });
    widget._callback("");
  }

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
                  widget._callback(t.shortcode);
                  _bindTapped(t);
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: t.color,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        t.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: t.tapped ? () => _removeBind(t) : () => {},
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: t.tapped
                              ? Icon(
                                  Icons.close,
                                  color: CustomTheme.white,
                                  size: 18,
                                )
                              : null,
                        ),
                      ),
                    ],
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
