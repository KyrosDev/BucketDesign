// Packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Utils
import '../../utils/Theme.dart';

// Views
import '../../chat/views/conversation.dart';

// Helper
import '../../helper/constants.dart';
import '../../helper/helperFunctions.dart';

// Services
import '../../services/database.dart';

class ChatRoomsList extends StatefulWidget {
  final String chatroomId;
  ChatRoomsList(this.chatroomId);

  @override
  _ChatRoomsListState createState() => _ChatRoomsListState();
}

class _ChatRoomsListState extends State<ChatRoomsList> {
  Stream chatRoomsStream;
  DBMethods dbMethods = DBMethods();

  @override
  void initState() {
    loadChats();
    super.initState();
  }

  loadChats() {
    dbMethods.getChatRooms(Constants.myUsername).then((val) {
      setState(() {
        chatRoomsStream = val;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snap) {
        if (!snap.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snap.data.documents.length,
          itemBuilder: (context, index) {
            return ChatTile(
              snap.data.documents[index].data["users"][0].toString(),
              lastMessage: snap.data.documents[index].data["lastMessage"].toString(),
              timeAgo: snap.data.documents[index].data["lastTime"],
            );
          },
        );
      },
    );
  }
}

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
                widget.snapshot.documents[index].data["username"],
                lastMessage: "Nevere type with this user.",
                timeAgo: 0,
              );
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
  QuerySnapshot searchSnapshot;
  String chatroomId;

  DBMethods dbMethods = DBMethods();

  searchResults(String username) {
    dbMethods.getUserByUsername(username).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    }).catchError((e) => print(e.toString()));
  }

  @override
  void initState() {
    getUserInfo();
    getId();
    print("chat id: $chatroomId");
    super.initState();
  }

  getId() async {
    await dbMethods.getChatRoomId(Constants.myUsername).then((val) {
      setState(() {
        chatroomId = "KyrosDesign_porco";
      });
    }).catchError((e) => print(e.toString()));
    print("secondo $chatroomId");
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
        if (search == true) SearchList(searchSnapshot),
        if (search == false) ChatRoomsList(chatroomId),
      ],
    );
  }
}

class ChatTile extends StatefulWidget {
  final String username;
  final String lastMessage;
  final int timeAgo;
  ChatTile(this.username, {this.lastMessage, this.timeAgo});

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  DBMethods dbMethods = DBMethods();

  createChatRoom(String username) {
    if (username != Constants.myUsername) {
      List<String> users = [username, Constants.myUsername];
      String chatRoomId = getChatRoomId(username, Constants.myUsername);
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId,
        "lastMessage": "",
        "lastTime": DateTime.now().millisecondsSinceEpoch,
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
  void initState() {
    super.initState();
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
                /* Positioned(
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
                ), */
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
                          widget.timeAgo == 0 ? "Never" : "${DateTime.fromMillisecondsSinceEpoch(widget.timeAgo).hour.toString()}:${DateTime.fromMillisecondsSinceEpoch(widget.timeAgo).minute.toString()}",
                          style: TextStyle(
                            color: CustomTheme.white.withOpacity(.6),
                            fontSize: 10,
                          ),
                        )
                    ],
                  ),
                  if (widget.username != Constants.myUsername)
                    if (widget.lastMessage != null)
                      Text(
                        widget.lastMessage,
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

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0))
    return "$b\_$a";
  else
    return "$a\_$b";
}
