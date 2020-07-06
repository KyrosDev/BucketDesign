// Packages
import 'package:flutter/material.dart';

// Widgets
import '../widgets/post_preview.dart';

// Utils
import '../utils/theme.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 40,
          right: 40,
          top: 104,
        ),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(seconds: 1),
              child: Text(
                "Welcome,",
                style: CustomTheme.uncoloredTitle,
              ),
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInExpo,
              child: Text(
                "Kyros Design",
                style: CustomTheme.coloredTitle,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            for (int i = 0; i < 5; i++) PostPreview(i),
          ],
        ),
      ),
    );
  }
}
