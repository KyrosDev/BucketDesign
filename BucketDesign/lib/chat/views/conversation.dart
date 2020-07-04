// Packages
import 'package:flutter/material.dart';

// Utils
import '../../utils/Theme.dart';

// Helper
import '../../helper/constants.dart';

// Services
import '../../services/database.dart';

class Converastion extends StatefulWidget {
  final String chatroomId;
  Converastion(this.chatroomId);

  @override
  _ConverastionState createState() => _ConverastionState();
}

class _ConverastionState extends State<Converastion> {
  TextEditingController _textController = TextEditingController();
  DBMethods dbMethods = DBMethods();

  sendMessage(String chatId, String message) {
    if (message.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "fromUsername": Constants.myUsername,
        "text": message,
        "date": DateTime.now().millisecondsSinceEpoch,
      };
      dbMethods.sendMessage(chatId, messageMap);
      _textController.clear();
      dbMethods
          .updateLastMessage({"lastMessage": messageMap["text"], "lastTime": messageMap["date"]}, chatId)
          .catchError((e) => print(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomId.split("_")[0]),
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
            ),
            onPressed: () => {},
          ),
        ],
        backgroundColor: CustomTheme.darkGray,
      ),
      backgroundColor: CustomTheme.darkGray,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.81,
            child: MessagesList(widget.chatroomId),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              controller: _textController,
              decoration: InputDecoration(
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.send,
                  ),
                  color: CustomTheme.mainColor,
                  hoverColor: CustomTheme.mainColorDarker,
                  onPressed: () =>
                      sendMessage(widget.chatroomId, _textController.text),
                ),
                fillColor: Color(0xFF4D4D4D),
                contentPadding: const EdgeInsets.only(
                  top: 24,
                  bottom: 24,
                  left: 28,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(0),
                ),
                hintText: "Type a message...",
                hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
              onSubmitted: (value) => sendMessage(widget.chatroomId, value),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatefulWidget {
  final String text;
  final String myMessage;
  final int date;
  MessageTile(this.text, this.myMessage, this.date);

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  String time;

  @override
  void initState() {
    getTimeMessage();
    super.initState();
  }

  getTimeMessage() {
    setState(() {
      time =
          "${DateTime.fromMillisecondsSinceEpoch(widget.date).hour.toString()}:${DateTime.fromMillisecondsSinceEpoch(widget.date).minute.toString()}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      alignment: widget.myMessage == Constants.myUsername
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.myMessage == Constants.myUsername
                ? [
                    CustomTheme.mainColor.withOpacity(.7),
                    CustomTheme.mainColor,
                  ]
                : [
                    Colors.white12.withOpacity(0.7),
                    Colors.white12,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: widget.myMessage == Constants.myUsername
              ? CustomTheme.mainColor
              : Colors.white12,
          borderRadius: widget.myMessage == Constants.myUsername
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              : BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
        ),
        child: Column(
          crossAxisAlignment: widget.myMessage == Constants.myUsername
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Container(
              width: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Spacer(),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.white.withOpacity(.6),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessagesList extends StatefulWidget {
  final String chatroomId;
  MessagesList(this.chatroomId);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  Stream chatMessagesStream;
  DBMethods dbMethods = DBMethods();

  @override
  void initState() {
    dbMethods.getMessages(widget.chatroomId).then((value) {
      setState(() {
        chatMessagesStream = value;
      });
    }).catchError((e) => print(e.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    snapshot.data.documents[index].data["text"],
                    snapshot.data.documents[index].data["fromUsername"],
                    snapshot.data.documents[index].data["date"],
                  );
                },
              )
            : Container();
      },
    );
  }
}
