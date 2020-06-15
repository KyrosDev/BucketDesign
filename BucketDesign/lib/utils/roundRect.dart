// Packages
import 'package:flutter/material.dart';

class RoundedRect extends StatelessWidget {
  final double radius;
  final Color color;
  final Widget child;
  final LinearGradient gradient;
  final List<BoxShadow> shadow;
  final double width, height;
  final EdgeInsets margin, padding;

  RoundedRect({this.radius, this.child, this.color, this.gradient, this.shadow, this.height, this.width, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          gradient: gradient != null ? gradient : null,
          boxShadow: shadow != null ? shadow : null,
        ),
        height: height,
        width: width,
        margin: margin != null ? margin : null,
        padding: padding != null ? padding : null,
        child: child
      ),
    );
  }
}