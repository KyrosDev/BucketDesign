// Packages
import 'package:flutter/material.dart';

// Widgets
import '../widgets/ownProfileInformations.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Container(
          width: double.infinity,
          child: OwnProfileInformations(),
        ),
      ),
    );
  }
}