// Packages
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  static const routeName = "/profile/edit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Center(
        child: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
