// Packages
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

// Utils
import '../utils/Theme.dart';
import '../models/Post.dart';

class PostPage extends StatefulWidget {
  static const routeName = "/post/";

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  int _currentIndex = 0;
  int _likes = 0;
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, Post> routeArgs =
        ModalRoute.of(context).settings.arguments;
    final Post post = routeArgs["post"];

    @protected
    @mustCallSuper
    void initState() {
      setState(() {
        _likes = post.likes;
      });
      super.initState();
    }

    void _like() {
      setState(() {
        _liked = true;
        _likes++;
      });
    }

    void _unlike() {
      setState(() {
        _liked = false;
        _likes--;
      });
    }

    void _changeImageByIndex(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    void _changeImageByScroll(DragEndDetails details) {
      if (post.attachments.length == 1) {
        setState(() {
          _currentIndex = 0;
        });
        return;
      }
      if (details.velocity.pixelsPerSecond.dx <= 0) {
        setState(() {
          if (_currentIndex == (post.attachments.length - 1)) {
            _currentIndex--;
          } else {
            _currentIndex++;
          }
        });
      } else if (details.velocity.pixelsPerSecond.dx >= 0) {
        setState(() {
          if (_currentIndex == (post.attachments.length - 1)) {
            _currentIndex--;
          } else {
            _currentIndex++;
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: CustomTheme.darkGray,
      appBar: AppBar(
        title: Text(
          post.title,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => {},
            icon: Icon(
              Icons.more_horiz,
            ),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: CustomTheme.darkGray,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              post.title,
              style: TextStyle(
                color: CustomTheme.white,
                fontSize: CustomTheme.titleSize,
              ),
            ),
            Text(
              "${post.author} · ${timeago.format(post.date)}",
              style: TextStyle(
                color: CustomTheme.white,
                fontSize: CustomTheme.bioSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  ...(post.tags).map((tag) {
                    return Container(
                      decoration: BoxDecoration(
                        color: tag.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(
                        tag.name,
                        style: TextStyle(
                          color: CustomTheme.white,
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
            GestureDetector(
              onDoubleTap: _liked ? () => {} : _like,
              onHorizontalDragEnd: (DragEndDetails details) =>
                  _changeImageByScroll(details),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: NetworkImage(post.attachments[_currentIndex]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: _liked ? _unlike : _like,
                          child: Icon(
                            Icons.favorite,
                            color: _liked ? Colors.red : Colors.white54,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            "$_likes",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: Icon(
                              Icons.comment,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            "${post.comments}",
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.share,
                    color: Colors.white54,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                post.description,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                ...(post.attachments).asMap().entries.map((val) {
                  int index = val.key;
                  String image = val.value;
                  return GestureDetector(
                    onTap: () => _changeImageByIndex(index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(image),
                        ),
                      ),
                    ),
                  );
                }).toList()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
