// Packages
import 'package:flutter/material.dart';

// Views
import '../views/post.dart';

// Widgets
import '../widgets/custom_icons_icons.dart';

// Utils
import '../utils/theme.dart';

class PostPreview extends StatefulWidget {
  final int index;
  PostPreview(this.index);

  @override
  _PostPreviewState createState() => _PostPreviewState();
}

class _PostPreviewState extends State<PostPreview> {
  double _size = 40;
  Color _iconColor = CustomTheme.mainColor;
  Color _circleColor = CustomTheme.white;
  double _radians = 0;
  IconData _icon = CustomIcons.heart_icon;
  Color _boxShadow = CustomTheme.white.withOpacity(0.4);

  void onLike() {
    setState(() {
      _iconColor = _iconColor == CustomTheme.mainColor
          ? CustomTheme.white
          : CustomTheme.mainColor;
      _circleColor = _circleColor == CustomTheme.white
          ? CustomTheme.mainColor
          : CustomTheme.white;
      _radians = _radians == 0 ? 6.283185 : 0;
      _icon = _icon == CustomIcons.heart_icon
          ? CustomIcons.heart_fill_icon
          : CustomIcons.heart_icon;
      _boxShadow = _boxShadow == CustomTheme.white.withOpacity(0.4)
          ? CustomTheme.mainColor.withOpacity(0.4)
          : CustomTheme.white.withOpacity(0.4);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);

    return Container(
      margin: const EdgeInsets.only(top: 28),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            left: widget.index % 2 != 0 ? -80 : null,
            right: widget.index % 2 == 0 ? -80 : null,
            top: 40,
            child: Transform.rotate(
              angle: (180 / 260),
              child: Icon(
                CustomIcons.user_smile_icon,
                color: CustomTheme.uncoloredText.withOpacity(.1),
                size: 70,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Post(
                  postId: widget.index.toString(),
                ),
              ),
            ),
            onDoubleTap: onLike,
            child: Hero(
              tag: "imageHero-${widget.index}",
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                width: mq.size.width * 0.6,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://www.esa.int/var/esa/storage/images/esa_multimedia/images/2020/03/single_arm_galaxy/21893256-1-eng-GB/Single_arm_galaxy_pillars.jpg",
                    ),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: widget.index % 2 != 0 ? -20 : null,
            right: widget.index % 2 == 0 ? -20 : null,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              padding: EdgeInsets.symmetric(horizontal: 4),
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      onLike();
                    },
                    child: Hero(
                      tag: "like-${widget.index}",
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInExpo,
                        decoration: BoxDecoration(
                          color: _circleColor,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: _boxShadow,
                              blurRadius: 20,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        width: _size,
                        height: _size,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          transform: Matrix4.rotationZ(_radians),
                          child: Icon(
                            _icon,
                            size: 15,
                            color: _iconColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: "comment-${widget.index}",
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomTheme.darkBack,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      width: 40,
                      height: 40,
                      child: Icon(
                        CustomIcons.chat_smile_icon,
                        size: 15,
                        color: Colors.black.withOpacity(.3),
                      ),
                    ),
                  ),
                  Hero(
                    tag: "share-${widget.index}",
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomTheme.darkBack,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      width: 40,
                      height: 40,
                      child: Icon(
                        CustomIcons.share_icon,
                        size: 15,
                        color: Colors.black.withOpacity(.3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: widget.index % 2 != 0 ? -20 : null,
            right: widget.index % 2 == 0 ? -200 : null,
            top: 14,
            child: Container(
              transform: Matrix4.rotationZ(1.570796),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Kyros Design",
                    style: TextStyle(
                        color: CustomTheme.uncoloredText.withOpacity(0.6),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "2 Hours Ago.",
                    style: TextStyle(
                      color: CustomTheme.uncoloredText.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
