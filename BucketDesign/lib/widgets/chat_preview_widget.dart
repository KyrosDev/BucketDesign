// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/Theme.dart';

// Views
import '../views/user_chat.dart';

class ChatPreviewWidget extends StatefulWidget {
  @override
  _ChatPreviewWidgetState createState() => _ChatPreviewWidgetState();
}

class _ChatPreviewWidgetState extends State<ChatPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(UserChat.routeName, arguments: {"user": "Kyros Design"}),
      child: Container(
        decoration: BoxDecoration(
          color: CustomTheme.darkGray,
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(.6),
              offset: Offset(0, 0),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
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
                      ),
                    ),
                    child: Text(
                      "10",
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
              width: 250,
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Kyros Design",
                        style: TextStyle(
                          color: CustomTheme.white,
                        ),
                      ),
                      Text(
                        "2 Day Ago",
                        style: TextStyle(
                          color: CustomTheme.white.withOpacity(.6),
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
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
