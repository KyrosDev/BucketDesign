// Packages
import 'package:flutter/material.dart';

// Models
import 'Tags.dart';

enum Difficulty{
  Simple,
  Intermediate,
  Hard,
  VeryHard,
}

enum MediaType {
  Photo,
  Video,
  Gif,
}

class Post {

  final String title;
  final String id;
  final String description;
  final Difficulty difficulty;
  final DateTime date;
  final String author;
  final List<String> attachments;
  final MediaType mediaType;
  final int likes;
  final int comments;
  final List<Tag> tags;
  final String preview;

  const Post({
    @required this.id,
    @required this.author,
    @required this.description,
    @required this.preview,
    @required this.difficulty,
    @required this.attachments,
    @required this.date,
    @required this.title,
    @required this.mediaType,
    this.tags,
    this.comments = 0,
    this.likes = 0,
  });

}