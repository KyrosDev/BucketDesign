// Packages
import 'package:flutter/material.dart';

// Models
import './Designer.dart';

class Comment {

  final String text;
  final String id;
  final String author; 
  final int likes;
  final DateTime date;

  Comment({
    @required this.id,
    @required this.text,
    @required this.author,
    @required this.date,
    this.likes,
  });

}