// Packages
import 'dart:io';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

// Utils
import '../../utils/Theme.dart';

class Settings extends StatefulWidget {
  static const routeName = "/profile/edit";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // My IPv4 192.168.1.116;

  File _file;
  final picker = ImagePicker();

  void choose() async {
    final PickedFile _picked =
        await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(_picked.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: CustomTheme.darkGray,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: CustomTheme.darkGray,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: _file == null
                      ? Center(
                          child: Text("No image Selected", style: TextStyle(color: Colors.white)),
                        )
                      : Image.file(
                          _file,
                          fit: BoxFit.cover,
                        ),
                ),
                Container(
                  width: 160,
                  child: RaisedButton(
                    onPressed: choose,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Choose Image"),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.file_upload,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
