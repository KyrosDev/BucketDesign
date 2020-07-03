// Packages
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

// Helper
import '../../helper/helperFunctions.dart';

// Services
import '../../services/database.dart';

// Utils
import '../../utils/Theme.dart';

// Views
import './profileSetup.dart';

class LoadPicture extends StatefulWidget {
  static const String routeName = "/load-picture";

  @override
  _LoadPictureState createState() => _LoadPictureState();
}

class _LoadPictureState extends State<LoadPicture> {
  File _file;
  final picker = ImagePicker();
  String username;

  void choose() async {
    final PickedFile _picked = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 3000,
      maxHeight: 3000,
      imageQuality: 100,
    );
    if (_picked != null) {
      setState(() {
        _file = File(_picked.path);
      });
    } else {
      return;
    }
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("/designers/$username/profilePicture/");
    StorageUploadTask uploadTask = storageReference.putFile(_file);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      HelperFunctions.getUserEmailSharedPreference().then((email) {
        DBMethods()
            .updateUserInformations({"profileImage": fileURL}, email);
      });
    }).catchError((e) => print("errore porcoddio $e"));
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  getUsername() async {
    HelperFunctions.getUsernameSharedPreference().then((user) {
      setState(() {
        username = user;
      });
      print(username);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.darkGray,
      appBar: PreferredSize(
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.transparent,
                ),
                onPressed: null,
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Container(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Color(0xFF4d4d4d),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Hero(
                    tag: "process",
                    child: Container(
                      width: _file != null ? 37.5 : 0,
                      height: 5,
                      decoration: BoxDecoration(
                        color: CustomTheme.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Hero(
                          tag: "1",
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomTheme.mainColor,
                            ),
                            child: Center(
                              child: Text(
                                "1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Hero(
                          tag: "2",
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF4d4d4d),
                            ),
                            child: Center(
                              child: Text(
                                "2",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.5),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Hero(
                          tag: "3",
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF4d4d4d),
                            ),
                            child: Center(
                              child: Text(
                                "3",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.5),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(),
              flex: 2,
            ),
          ],
        ),
        preferredSize: Size(double.infinity, 80),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              onTap: choose,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: _file == null
                      ? LinearGradient(
                          colors: [
                            CustomTheme.mainColor,
                            CustomTheme.mainColorDarker,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomTheme.mainColor.withOpacity(.2),
                      offset: Offset(10, 10),
                      blurRadius: 30,
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  image: _file == null
                      ? null
                      : DecorationImage(
                          image: FileImage(
                            _file,
                          ),
                          fit: BoxFit.cover),
                ),
                child: _file == null
                    ? Icon(
                        Icons.file_upload,
                        color: Colors.white,
                        size: 60,
                      )
                    : null,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 200,
              child: Text(
                "Add a profile picture.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            if (_file != null)
              GestureDetector(
                onTap: () {
                  uploadFile();
                  Navigator.pushNamed(context, ProfileSetup.routeName);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 26),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 36),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        CustomTheme.mainColor,
                        CustomTheme.mainColorDarker,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: CustomTheme.mainColor.withOpacity(.2),
                        offset: Offset(10, 10),
                        blurRadius: 30,
                      )
                    ],
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
