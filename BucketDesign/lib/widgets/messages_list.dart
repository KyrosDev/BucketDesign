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
      height: (mq.size.height -
              widget.appBar.preferredSize.height -
              mq.padding.bottom -
              20) *
          0.9,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
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
                    "How are you? i'm fine and you? how are you?",
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
