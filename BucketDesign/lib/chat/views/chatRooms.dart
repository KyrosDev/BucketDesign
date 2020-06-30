// Packages
import 'package:BucketDesign/chat/views/conversation.dart';
import 'package:BucketDesign/helper/constants.dart';
import 'package:BucketDesign/helper/helperFunctions.dart';
import 'package:BucketDesign/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Utils
import '../../utils/Theme.dart';

class SearchList extends StatefulWidget {
  final QuerySnapshot snapshot;
  SearchList(this.snapshot);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return widget.snapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: widget.snapshot.documents.length,
            itemBuilder: (context, index) {
              return ChatTile(
                  widget.snapshot.documents[index].data["username"]);
            },
          )
        : Container();
  }
}

class ChatRoomsView extends StatefulWidget {
  @override
  _ChatRoomsViewState createState() => _ChatRoomsViewState();
}

class _ChatRoomsViewState extends State<ChatRoomsView> {
  bool search = false;
  QuerySnapshot snapshot;

  DBMethods dbMethods = new DBMethods();

  searchResults(String username) {
    dbMethods.getUserByUsername(username).then((val) {
      setState(() {
        snapshot = val;
      });
    }).catchError((e) => print(e.toString()));
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myUsername = await HelperFunctions.getUsernameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
        ),
        if (search)
          Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 40),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                filled: true,
                fillColor: Color(0xFF4D4D4D),
                hintText: "Search user...",
                contentPadding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
                hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              onSubmitted: searchResults,
              onChanged: searchResults,
              toolbarOptions: ToolbarOptions(
                copy: true,
                paste: true,
                selectAll: true,
                cut: true,
              ),
            ),
          ),
        SearchList(snapshot),
      ],
    );
  }
}

class ChatTile extends StatefulWidget {
  final String username;
  ChatTile(this.username);

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  DBMethods dbMethods = DBMethods();

  createChatRoom(String username) {
    if (username != Constants.myUsername) {
      List<String> users = [username, Constants.myUsername];
      String chatRoomId = users.join("_");
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId,
      };
      dbMethods.createRoom(chatRoomId, chatRoomMap);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Converastion(chatRoomId),
        ),
      );
    } else
      print("you can't chat with urself");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => createChatRoom(widget.username),
      child: Container(
        decoration: BoxDecoration(
          color: CustomTheme.darkGray,
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.1),
              style: BorderStyle.solid,
              width: 2,
            ),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/99435530_688882545270142_7984536088211009073_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=110&_nc_ohc=fJIgQobqAOsAX_BgaHo&oh=5b0be728646f442dcd2db3ae258c1a8b&oe=5F1961EE",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomTheme.mainColor,
                      border: Border.all(
                        color: CustomTheme.darkGray,
                        width: 3,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Text(
                      "234",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width - 94,
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.username == Constants.myUsername
                            ? "${widget.username} (Yourself)"
                            : widget.username,
                        style: TextStyle(
                          color: CustomTheme.white,
                        ),
                      ),
                      if (widget.username != Constants.myUsername)
                        Text(
                          "2 Day Ago",
                          style: TextStyle(
                            color: CustomTheme.white.withOpacity(.6),
                            fontSize: 10,
                          ),
                        )
                    ],
                  ),
                  if (widget.username != Constants.myUsername)
                    Text(
                      "Hello, how are you?asd asd asd ags gsfd ",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: CustomTheme.white.withOpacity(.6),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
