// Packages
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

// Utils
import '../utils/Theme.dart';

class FullImageViewer extends StatelessWidget {
  static const routeName = "/post/image/";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;
    dynamic imagePath = arguments["url"];
    String title = arguments["title"];
    return Scaffold(
      appBar: AppBar(
        title: Text(title + " Image"),
        backgroundColor: CustomTheme.darkGray,
      ),
      body: Container(
        child: GestureDetector(
          onVerticalDragEnd: (_) => Navigator.of(context).pop(),
          child: PhotoView(
            imageProvider: NetworkImage(imagePath),
            maxScale: PhotoViewComputedScale.covered,
            minScale: PhotoViewComputedScale.contained,
          ),
        ),
      ),
    );
  }
}
