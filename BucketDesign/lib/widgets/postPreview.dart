// Packages
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

// Views
import '../views/postDetails.dart';

// Models
import '../models/Post.dart';

// Utils
import '../utils/Theme.dart';

class PostPreview extends StatelessWidget {
  final Post post;
  PostPreview(this.post);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(PostPage.routeName, arguments: {"post": post}),
      onLongPress: () => print(post.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 250,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(
                post.preview,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp,
              ),
            ),
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.title,
                  style: TextStyle(
                    color: CustomTheme.white,
                    fontSize: CustomTheme.titleSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "${post.author} · ${timeago.format(post.date)}",
                  style: TextStyle(
                    color: CustomTheme.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
