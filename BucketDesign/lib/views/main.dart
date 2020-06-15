// Packages
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Widgets
import '../pages/popuplar_hastags.dart';
import '../pages/recommended_designers.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      dragStartBehavior: DragStartBehavior.down,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RecommendedDesigners(),
          HastagsSection(),
        ],
      ),
    );
  }
}
