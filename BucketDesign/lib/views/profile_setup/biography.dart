// Packages
import 'package:flutter/material.dart';

// Utils
import '../../utils/Theme.dart';

// Views
import '../../views/home.dart';

class WriteBiography extends StatefulWidget {
  static const String routeName = "/write_biography";

  @override
  _WriteBiographyState createState() => _WriteBiographyState();
}

class _WriteBiographyState extends State<WriteBiography> {
  String biography;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Center(
              child: Container(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color(0xFF4d4d4d),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Hero(
                      tag: "process",
                      child: Container(
                        width: 150,
                        height: 5,
                        decoration: BoxDecoration(
                          color: CustomTheme.mainColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Hero(
                            tag: "1",
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CustomTheme.mainColor,
                              ),
                              child: Center(
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Hero(
                            tag: "2",
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CustomTheme.mainColor,
                              ),
                              child: Center(
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Hero(
                            tag: "3",
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CustomTheme.mainColor,
                              ),
                              child: Center(
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 2,
            ),
          ],
        ),
        preferredSize: Size(double.infinity, 80),
      ),
      backgroundColor: CustomTheme.darkGray,
      body: Center(
        child: GestureDetector(
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(Home.routeName),
          child: Container(
            child: Text(
              "Go to home",
            ),
          ),
        ),
      ),
    );
  }
}
