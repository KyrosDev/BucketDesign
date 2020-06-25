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
  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return Container(
      constraints: BoxConstraints(maxWidth: mq.size.width * 0.6),
      height: (mq.size.height -
              widget.appBar.preferredSize.height -
              mq.padding.top) *
          0.9,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CustomTheme.mainColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "How are you?",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
