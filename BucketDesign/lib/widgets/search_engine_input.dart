// Packages
import 'package:flutter/material.dart';

class SearchEngineInput extends StatelessWidget {

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 40),
      child: TextField(
        controller: _textController,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: const BorderRadius.all(
              const Radius.circular(20.0),
            ),
          ),
          filled: true,
          fillColor: Color(0xFF4D4D4D),
          hintText: "Search...",
          contentPadding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
          hintStyle: TextStyle(
            color: Colors.white70,
            fontSize: 18,
          ),
        ),
        onSubmitted: (value) => print(_textController.text),
      ),
    );
  }
}