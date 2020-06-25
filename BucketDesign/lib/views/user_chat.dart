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
      title: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
                ),
              ),
              Positioned(
                right: 8,
                bottom: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.lightGreen,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(arguments["user"]),
              Text(
                "Online",
                style: TextStyle(
                  color: CustomTheme.white.withOpacity(.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
          onPressed: () => {},
        ),
      ],
      backgroundColor: CustomTheme.darkGray,
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: (mq.size.height - mq.padding.top),
        width: double.infinity,
        color: CustomTheme.darkGray,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MessagesList(appBar),
              Container(
                color: Colors.transparent,
                height: (mq.size.height -
                        mq.padding.top -
                        appBar.preferredSize.height -
                        115) *
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
