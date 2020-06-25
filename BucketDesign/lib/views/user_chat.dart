// Packages
import 'package:flutter/material.dart';

class UserChat extends StatefulWidget {
  static const routeName = "/chat/";

  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments["user"]),
      ),
      body: Container(
        child: Text(
          arguments.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
