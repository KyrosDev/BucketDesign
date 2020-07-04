// Packages
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  final int tapped;
  final List<Map<String, dynamic>> items;
  final Function callback;
  CustomNavigationBar({this.tapped, this.callback, this.items});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final double _size = 4;
  double bottomNabHeight = 65;
  double _marginBottom = 8;
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: bottomNabHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Container(
          height: bottomNabHeight,
          padding: const EdgeInsets.only(left: 35, right: 35),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 30,
                color: Colors.black.withOpacity(.05),
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ...(widget.items).map((item) {
                return GestureDetector(
                  onTap: () {
                    widget.callback(item["index"]);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.fastOutSlowIn,
                        margin: widget.tapped == item["index"]
                            ? EdgeInsets.only(bottom: _marginBottom)
                            : EdgeInsets.only(bottom: 0),
                        child: Icon(
                          item["icon"],
                          size: 22,
                          color: widget.tapped == item["index"]
                              ? Color(0xFF2EC0F9)
                              : Color(0xFF4D4D4D),
                        ),
                      ),
                      if (widget.tapped == item["index"])
                        AnimatedContainer(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOutCubic,
                          width: _size,
                          height: _size,
                          decoration: BoxDecoration(
                            color: Color(0xFF2EC0F9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
              Container(
                width: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
