// Package
import 'package:flutter/material.dart';

class Designer {

  String id;
  String username;
  String profession;
  String professionShortcode;
  int followers;
  int follows;
  int posts;
  int likes;
  Color color;

  Designer({this.username, this.followers, this.follows, this.id, this.posts, this.likes, this.profession, this.professionShortcode, this.color});

}