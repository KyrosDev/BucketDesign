// Packages
import 'package:BucketDesign/helper/helperFunctions.dart';
import 'package:BucketDesign/services/database.dart';
import 'package:flutter/material.dart';

// Utils
import '../utils/me.dart';

// Widgets
import '../utils/roundRect.dart';

class MainAppBar extends StatefulWidget {
  final bool profile;
  final Function callback;

  MainAppBar(this.callback, this.profile);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  String email;
  String imageUrl;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() {
    HelperFunctions.getUserEmailSharedPreference().then((userEmail) {
      DBMethods().getUserByUserEmail(userEmail).then((user) {
        setState(() {
          imageUrl = "${user.documents[0].data["profileImage"]}";
          email = userEmail;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/icons/long_main_color_text_logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.callback,
              child: RoundedRect(
                width: 30,
                height: 30,
                radius: 5,
                color: Colors.transparent,
                shadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                    color: Colors.black,
                  ),
                ],
                child: Container(
                  decoration: BoxDecoration(
                    image: imageUrl == null
                        ? null
                        : DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
