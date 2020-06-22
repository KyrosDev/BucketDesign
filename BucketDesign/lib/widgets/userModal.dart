// Packages
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Utils
import '../utils/Theme.dart';
import '../utils/roundRect.dart';

// Models
import '../models/Designer.dart';

class UserModal extends StatefulWidget {
  final Designer t;

  UserModal(this.t);

  @override
  _UserModalState createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  bool following = false;

  void _followHandler() {
    setState(() {
      following = !following;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RoundedRect(
      radius: 30,
      color: CustomTheme.darkGray,
      height: 350,
      padding: EdgeInsets.all(30),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.only(
                    right: 20,
                  ),
                  child: SvgPicture.asset(
                    "assets/user/kyros.svg",
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.t.profession,
                          style: TextStyle(
                            color: CustomTheme.white,
                            fontSize: CustomTheme.professionSize,
                          ),
                        ),
                        Text(
                          widget.t.username.length >= 14
                              ? widget.t.username.split(" ")[0] + "..."
                              : widget.t.username,
                          style: TextStyle(
                            color: CustomTheme.white,
                            fontSize: CustomTheme.titleSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color.fromRGBO(29, 29, 29, 1.0),
              ),
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: CustomTheme.darkGray,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.group,
                            size: 30,
                            color: CustomTheme.white,
                          ),
                          Text(
                            widget.t.followers >= 1000
                                ? "${widget.t.followers.toString()[0]}k"
                                : widget.t.followers >= 10000
                                    ? "${widget.t.followers.toString()[0]}${widget.t.followers.toString()[1]}k"
                                    : "${widget.t.followers}",
                            style: TextStyle(
                              color: CustomTheme.white,
                              fontSize: CustomTheme.subtitleSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: CustomTheme.darkGray,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.image,
                            size: 30,
                            color: CustomTheme.white,
                          ),
                          Text(
                            "${widget.t.posts}",
                            style: TextStyle(
                              color: CustomTheme.white,
                              fontSize: CustomTheme.subtitleSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: CustomTheme.darkGray,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.favorite,
                            size: 30,
                            color: CustomTheme.white,
                          ),
                          Text(
                            "${widget.t.likes}",
                            style: TextStyle(
                              color: CustomTheme.white,
                              fontSize: CustomTheme.subtitleSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: following
                    ? Color.fromRGBO(50, 50, 50, 1)
                    : CustomTheme.mainColor,
              ),
              child: GestureDetector(
                onTap: _followHandler,
                child: Text(
                  following == true ? "Unfollow" : "Follow",
                  style: TextStyle(
                    color: CustomTheme.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
