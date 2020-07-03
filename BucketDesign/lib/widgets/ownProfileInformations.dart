// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';
import '../utils/me.dart';

// Widgets
import '../widgets/profileCounters.dart';

class OwnProfileInformations extends StatelessWidget {
  final String profilePicUrl;
  final String username;
  final String profession;
  OwnProfileInformations({this.profilePicUrl, this.profession, this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 20),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(profilePicUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  username,
                  style: TextStyle(
                    color: CustomTheme.white,
                    fontSize: CustomTheme.titleSize,
                  ),
                ),
                Text(
                  profession,
                  style: TextStyle(
                    color: CustomTheme.gray,
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 250,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      me.biography,
                      style: TextStyle(
                        color: CustomTheme.gray,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: ProfileCounters(
                  followersCounter: me.followers,
                  postsCounter: me.postsCounter,
                  likesCounter: me.likes,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: "Sailec",
                    color: CustomTheme.white,
                    fontSize: CustomTheme.titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "Posts",
                    ),
                    TextSpan(
                      text: ".",
                      style: TextStyle(
                        color: CustomTheme.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              /* GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
                children: <Widget>[
                  ...(me.posts).map((post) {
                    return Container(
                      color: Colors.red,
                    );
                  }).toList()
                ],
              ), */
            ],
          ),
        ),
      ],
    );
  }
}
