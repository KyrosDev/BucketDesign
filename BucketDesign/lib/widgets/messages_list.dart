// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

class MessagesList extends StatefulWidget {
  final AppBar appBar;
  MessagesList(this.appBar);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  List<Map<String, dynamic>> messages = [
    {
      "text": "This is my fourth message",
      "int": 3,
    },
    {
      "text": "This is my third message",
      "int": 2,
    },
    {
      "text": "This is my second message",
      "int": 1,
    },
    {
      "text": "This is my first message. Say hello now!!!",
      "int": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return Container(
      height: (mq.size.height -
              widget.appBar.preferredSize.height -
              mq.padding.bottom -
              20) *
          0.9,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: messages.length,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: index == 0
                      ? Colors.red
                      : Colors.transparent,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: CustomTheme.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: mq.size.width * 0.6),
                  child: Text(
                    messages[index]["text"],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
