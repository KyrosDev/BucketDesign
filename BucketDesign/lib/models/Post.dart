import 'package:flutter/material.dart';

enum Difficulty{
  Simple,
  Intermediate,
  Hard,
  VeryHard,
}

enum MediaType {
  Photo,
  Video,
}

class Post {

  final String title;
  final String id;
  final String description;
  final Difficulty difficulty;
  final int time;
  final String author;
  final List<String> imageUrl;
  final MediaType mediaType;

  Post({
    @required this.id,
    @required this.author,
    @required this.description,
    @required this.difficulty,
    @required this.imageUrl,
    @required this.time,
    @required this.title,
    @required this.mediaType,
  });

}