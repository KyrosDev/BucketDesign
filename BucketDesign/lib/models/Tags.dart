// Packages
import 'package:flutter/material.dart';

class Tag {
  String name;
  String shortcode;
  Color color;
  String id;
  bool tapped;

  Tag({
    @required this.name,
    this.tapped,
    this.color = Colors.green,
    @required this.shortcode,
    @required this.id,
  });
}
