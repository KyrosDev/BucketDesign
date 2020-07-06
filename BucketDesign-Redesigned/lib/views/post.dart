// Packages
import 'package:flutter/material.dart';

// Utils
import '../utils/theme.dart';

// Widgets
import '../widgets/custom_icons_icons.dart';

class Post extends StatefulWidget {
  final String postId;
  Post({this.postId});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.mainColor,
        elevation: 0,
        title: Text("KyrosDesign - Un Semplice Ti Amo."),
        leading: IconButton(
          highlightColor: CustomTheme.mainColor,
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_horiz,
            ),
            onPressed: () => {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Hero(
                  tag: "imageHero-${widget.postId}",
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://instagram.fcia1-1.fna.fbcdn.net/v/t51.2885-15/e35/82562330_272512647140248_4367216450983926214_n.jpg?_nc_ht=instagram.fcia1-1.fna.fbcdn.net&_nc_cat=104&_nc_ohc=XwfIOEHmZ98AX9oxeW7&oh=b6dc0d584211c11903cb00b359e95bbd&oe=5F2CA8A1",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40,
                  left: 20,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: onLike,
                          child: Column(
                            children: <Widget>[
                              Hero(
                                tag: "like-${widget.postId}",
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
                                  width: 50,
                                  height: 50,
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    transform: Matrix4.rotationZ(_radians),
                                    child: Icon(
                                      _icon,
                                      size: 17,
                                      color: _iconColor,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "234",
                                style: TextStyle(
                                  color: Colors.black.withOpacity(.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Hero(
                              tag: "comment-${widget.postId}",
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
                            Text(
                              "0",
                              style: TextStyle(
                                color: Colors.black.withOpacity(.5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Hero(
                              tag: "share-${widget.postId}",
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
                            Text(""),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -60,
                  top: 90,
                  child: Icon(
                    CustomIcons.pen_icon,
                    size: 40,
                    color: Colors.black.withOpacity(.2),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  decoration: BoxDecoration(
                    color: CustomTheme.mainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        color: CustomTheme.mainColor.withOpacity(.3),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(top: 70),
                  padding: EdgeInsets.symmetric(
                    horizontal: CustomTheme.mainHorizontalPading * 2,
                    vertical: 24,
                  ),
                  child: Text(
                    "This is the dedscription of the post. Ma lol quanto cazzo è lungo?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
