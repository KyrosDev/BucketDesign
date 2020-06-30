// Packages
import 'package:BucketDesign/chat/models/Message.dart';
import 'package:BucketDesign/helper/constants.dart';
import 'package:BucketDesign/services/database.dart';
import 'package:BucketDesign/utils/Theme.dart';
import 'package:flutter/material.dart';

class Converastion extends StatefulWidget {
  final String chatroomId;
  Converastion(this.chatroomId);

  @override
  _ConverastionState createState() => _ConverastionState();
}

class _ConverastionState extends State<Converastion> {
  TextEditingController _textController = TextEditingController();
  DBMethods dbMethods = DBMethods();

  Stream chatMessagesStream;

  Widget ChatMessagesList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  print(snapshot.data.documents[index].data["text"]);
                  return MessageTile(
                    snapshot.data.documents[index].data["text"],
                    snapshot.data.documents[index].data["fromUsername"],
                  );
                },
              )
            : Container();
      },
    );
  }

  sendMessage(String chatId, String message) {
    if (message.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "fromUsername": Constants.myUsername,
        "text": message,
        "date": DateTime.now().millisecondsSinceEpoch,
      };
      dbMethods.sendMessage(chatId, messageMap);
      _textController.clear();
    }
  }

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
          ChatMessagesList(),
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

class MessageTile extends StatelessWidget {
  final String text;
  final String myMessage;
  MessageTile(this.text, this.myMessage);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      alignment: myMessage == Constants.myUsername
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
          color: myMessage == Constants.myUsername
              ? CustomTheme.mainColor
              : Colors.white12,
          borderRadius: myMessage == Constants.myUsername
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
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
