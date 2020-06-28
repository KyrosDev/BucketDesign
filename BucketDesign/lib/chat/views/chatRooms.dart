// Packages
import '../widgets/chat_preview_widget.dart';
import 'package:flutter/material.dart';

// Utils
import '../../utils/Theme.dart';

class ChatRoomsView extends StatefulWidget {
  @override
  _ChatRoomsViewState createState() => _ChatRoomsViewState();
}

class _ChatRoomsViewState extends State<ChatRoomsView> {
  bool search = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: CustomTheme.titleSize,
                      fontFamily: 'Sailec',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Chats",
                      ),
                      TextSpan(
                        text: ".",
                        style: TextStyle(
                          color: CustomTheme.mainColor,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                      onPressed: () => {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () => setState(() {
                        search = !search;
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (search)
            Text(
              "Helo",
              style: TextStyle(color: Colors.white),
            ),
          for (int i = 0; i < 4; i++) ChatPreviewWidget(),
        ],
      ),
    );
  }
}
