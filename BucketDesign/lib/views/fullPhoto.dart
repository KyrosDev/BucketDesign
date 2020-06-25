// Packages
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// Utils
import '../utils/Theme.dart';

// Models
import '../models/Post.dart';

class FullImageViewer extends StatelessWidget {
  static const routeName = "/post/image/";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    Post post = arguments["post"];
    String url = arguments["url"];
    return Scaffold(
      appBar: AppBar(
        title: Text("${post.title} Image"),
        backgroundColor: CustomTheme.darkGray,
      ),
      body: Hero(
        tag: "image${post.id}",
        child: Container(
          child: GestureDetector(
            onVerticalDragEnd: (_) => Navigator.of(context).pop(),
            child: PhotoView(
              imageProvider: NetworkImage(url),
              maxScale: PhotoViewComputedScale.covered,
              minScale: PhotoViewComputedScale.contained,
            ),
          ),
        ),
      ),
    );
  }
}
