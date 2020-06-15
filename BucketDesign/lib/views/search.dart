// Packages
import 'package:flutter/material.dart';

// Widgets
import '../widgets/searchBar.dart';
import '../widgets/recommended_tag_listview.dart';
import '../widgets/searchResults.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _textController = TextEditingController();
  String _text = "";
  String _profession = "";

  void _sendText(String val) {
    setState(() {
      _text = _textController.text;
    });
  }

  void _filterByTag(String profession) {
    setState(() {
      _profession = profession;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SearchBar(_sendText, _textController),
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
                TagsListView(_filterByTag),
                SearchResult(_text, _profession),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
