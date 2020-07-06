// Packages
import 'package:flutter/material.dart';

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
            left: -80,
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
            onTap: () => print("sei gay"),
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
                      "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/82562330_272512647140248_4367216450983926214_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=104&_nc_ohc=XwfIOEHmZ98AX9oxeW7&oh=b6dc0d584211c11903cb00b359e95bbd&oe=5F2CA8A1",
                    ),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -20,
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
                  Container(
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
                  Container(
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
                ],
              ),
            ),
          ),
          Positioned(
            left: -20,
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
                      fontWeight: FontWeight.bold
                    ),
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
