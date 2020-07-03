// Packages
import 'package:flutter/material.dart';

// Helper
import '../helper/helperFunctions.dart';

// Services
import '../services/database.dart';

// Widgets
import '../widgets/ownProfileInformations.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String imageUrl;
  String email;
  String username;
  Map profession;

  @override
  void initState() {
    getUser();
    setState(() {});
    super.initState();
  }

  getUser() {
    HelperFunctions.getUserEmailSharedPreference().then((userEmail) {
      DBMethods().getUserByUserEmail(userEmail).then((user) {
        setState(() {
          imageUrl = "${user.documents[0].data["profileImage"]}";
          email = userEmail;
          username = user.documents[0].data["username"];
          profession = user.documents[0].data["profession"];
        });
        print("$imageUrl, $email, $username, $profession");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: imageUrl == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: double.infinity,
                child: OwnProfileInformations(
                  profession:
                      profession == null ? "No profession" : profession["name"],
                  profilePicUrl: imageUrl,
                  username: username,
                ),
              ),
      ),
    );
  }
}
