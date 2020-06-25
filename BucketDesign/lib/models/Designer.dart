// Package
import 'package:flutter/material.dart';

// Models
import './Post.dart';

enum Profession {
  UiDesigner,
  WebDesigner,
  GraphicDesigner,
  IndustrialProductDesigner,
  MotionGraphicDesigner,
  FashionDesigner,
  ArchitecturalDesigner,
}

class Designer {
  final String id;
  final String username;
  final Profession userProfession;
  final String professionShortcode;
  final String biography;
  final String profileImage;
  final int followers;
  final int follows;
  final List<Post> posts;
  final int postsCounter;
  final int likes;
  final Color color;

  String get profession {
    String val = "";
    if (userProfession == Profession.ArchitecturalDesigner) {
      val = "Architectural Designer";
    }
    if (userProfession == Profession.FashionDesigner) {
      val = "Fashion Designer";
    }
    if (userProfession == Profession.GraphicDesigner) {
      val = "Graphic Designer";
    }
    if (userProfession == Profession.IndustrialProductDesigner) {
      val = "Industrial Product Designer";
    }
    if (userProfession == Profession.MotionGraphicDesigner) {
      val = "Motion Graphic Designer";
    }
    if (userProfession == Profession.UiDesigner) {
      val = "UI Designer";
    }
    if (userProfession == Profession.WebDesigner) {
      val = "Web Designer";
    }
    return val;
  }

  Designer({
    @required this.username,
    this.profileImage,
    @required this.id,
    this.biography,
    this.followers = 0,
    this.follows = 0,
    this.posts,
    this.likes = 0,
    @required this.userProfession,
    this.postsCounter,
    this.professionShortcode,
    this.color
  });
}
