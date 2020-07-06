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
    Size size = MediaQuery.of(context).size;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: CustomTheme.mainHorizontalPading * 2.5,
              ),
              // It will cover 20% of our total height
              height: size.height * 0.3,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: CustomTheme.mainHorizontalPading * 2,
                      right: CustomTheme.mainHorizontalPading * 2,
                      top: MediaQuery.of(context).padding.top,
                    ),
                    height: size.height * 0.3 - 27,
                    decoration: BoxDecoration(
                      color: CustomTheme.mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Hi Designer!',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-19/s150x150/93266270_520174962009207_8404493275846672384_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_ohc=RKRzhnbfJo4AX_9QqFm&oh=7f081fae3296838f7a1734620e067a6f&oe=5F2B9681",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < 5; i++)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.mainHorizontalPading * 2,
                ),
                child: Align(
                  alignment:
                      i % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
                  child: PostPreview(i),
                ),
              ),
            SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
