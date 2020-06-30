// Packages
import 'package:flutter/material.dart';

enum MessageType {
  TextMessage,
  MediaMessage,
  VoiceMessage,
  LinkMessage,
  ReplyiedMessage,
}

class Message {
  final String id;
  final String fromId;
  final String toId;
  final DateTime date;
  final String message;
  final MessageType messageType;

  Message({
    @required this.id,
    @required this.fromId,
    @required this.toId,
    @required this.date,
    @required this.message,
    this.messageType,
  });
}
