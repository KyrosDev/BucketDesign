// Packages
import 'package:flutter/material.dart';

// Widgets
import '../widgets/postPreview.dart';
import '../widgets/popuplar_hastags.dart';
import '../widgets/recommended_designers.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RecommendedDesigners(),
          HastagsSection(),
          PostPreview(),
        ],
      ),
    );
  }
}