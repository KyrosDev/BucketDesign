// Packages
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  static const String routeName = "/loading"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
