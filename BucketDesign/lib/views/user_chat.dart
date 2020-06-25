// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

// Widgets
import '../widgets/messages_list.dart';

class UserChat extends StatefulWidget {
  static const routeName = "/chat/";

  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    MediaQueryData mq = MediaQuery.of(context);

    AppBar appBar = AppBar(
      title: Text(arguments["user"]),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: CustomTheme.darkGray,
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: (mq.size.height - mq.padding.top),
        color: CustomTheme.darkGray,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MessagesList(appBar),
              Container(
                height: (mq.size.height -
                        mq.padding.top -
                        appBar.preferredSize.height) *
                    0.1,
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => {},
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(50.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Color(0xFF4D4D4D),
                    hintText: "Write a message...",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                    prefixIcon: IconButton(
                      onPressed: () => print("asdasd"),
                      icon: Icon(
                        Icons.insert_emoticon,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
