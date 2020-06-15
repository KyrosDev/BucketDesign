// Packages
import 'package:flutter/material.dart';

// Widgets
import '../widgets/recommended_tag_listview.dart';
import '../widgets/search_engine_input.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SearchEngineInput(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: "Recommended",
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
                ),
                TagsListView(),
              ],
            ),
          ],
        ));
  }
}
