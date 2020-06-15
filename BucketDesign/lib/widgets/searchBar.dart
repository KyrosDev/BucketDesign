// Packages
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function _callback;
  final TextEditingController _controller;

  SearchBar(this._callback, this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 40),
      child: TextField(
        controller: _controller,
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
        onChanged: (value) => _callback(value),
        onSubmitted: (value) => _callback(value),
      ),
    );
  }
}
