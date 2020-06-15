// Package
import 'package:flutter/material.dart';

class UploadView extends StatefulWidget {
  @override
  _UploadViewState createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Upload", style: TextStyle(color: Colors.white))
    );
  }
}