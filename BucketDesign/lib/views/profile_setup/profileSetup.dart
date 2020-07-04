// Packages
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// Views
import '../../views/profile_setup/biography.dart';

// Services
import '../../services/database.dart';

// Helper
import '../../helper/helperFunctions.dart';

// Utils
import '../../utils/Theme.dart';

class ProfileSetup extends StatefulWidget {
  static const String routeName = "/profile-setup";

  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  Map<String, dynamic> profession;

  setProfession(newProfession) {
    setState(() {
      profession = newProfession;
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
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
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
                      width: profession != null ? 110 : 75,
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
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomTheme.mainColor,
                            ),
                            child: Center(
                              child: Text(
                                "1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Hero(
                          tag: "2",
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomTheme.mainColor,
                            ),
                            child: Center(
                              child: Text(
                                "2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
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
            Container(
              width: double.infinity,
              height: 130,
              child: ProfessionsChooser(setProfession),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.only(top: 16),
              child: Text(
                "Choose your profession.",
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
            if (profession != null)
              GestureDetector(
                onTap: () {
                  HelperFunctions.getUserEmailSharedPreference().then((email) {
                    DBMethods().updateUserInformations(
                      {
                        "profession": {
                          "name": profession["name"],
                          "id": profession["id"],
                        }
                      },
                      email,
                    );
                  }).catchError((e) => print(e.toString()));
                  Navigator.of(context).pushNamed(WriteBiography.routeName);
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

class ProfessionsChooser extends StatefulWidget {
  final Function callback;
  ProfessionsChooser(this.callback);

  @override
  _ProfessionsChooserState createState() => _ProfessionsChooserState();
}

class _ProfessionsChooserState extends State<ProfessionsChooser> {
  List<Map<String, dynamic>> professionsArray = [
    {
      "name": "UI Designer",
      "id": "ui_designer",
      "colors": [
        Colors.amber.withOpacity(.6),
        Colors.amber,
      ],
    },
    {
      "name": "UX Designer",
      "id": "ux_designer",
      "colors": [
        Colors.blueAccent.withOpacity(.6),
        Colors.blueAccent,
      ],
    },
    {
      "name": "Graphic Designer",
      "id": "graphic_designer",
      "colors": [
        Colors.brown.withOpacity(.6),
        Colors.brown,
      ],
    },
    {
      "name": "Motion Designer",
      "id": "motion_designer",
      "colors": [
        Colors.green.withOpacity(.6),
        Colors.green,
      ],
    },
    {
      "name": "Web Designer",
      "id": "web_designer",
      "colors": [
        Colors.deepPurple.withOpacity(.6),
        Colors.deepPurple,
      ],
    },
    {
      "name": "Product Designer",
      "id": "product_designer",
      "colors": [
        Colors.pinkAccent.withOpacity(.6),
        Colors.pinkAccent,
      ],
    },
    {
      "name": "Animation Designer",
      "id": "animation_designer",
      "colors": [
        Colors.lime.withOpacity(.6),
        Colors.lime,
      ],
    },
    {
      "name": "Fashion Designer",
      "id": "fashion_designer",
      "colors": [
        Colors.orange.withOpacity(.6),
        Colors.orange,
      ],
    },
    {
      "name": "Architect. Designer",
      "id": "architectural_designer",
      "colors": [
        Colors.red.withOpacity(.6),
        Colors.red,
      ],
    },
  ];

  int _tapped;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      dragStartBehavior: DragStartBehavior.start,
      scrollDirection: Axis.horizontal,
      itemCount: professionsArray.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _tapped = index;
            });
            widget.callback(professionsArray[_tapped]);
          },
          child: Container(
            margin: index == 0
                ? EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2 - 80)
                : index == professionsArray.length - 1
                    ? EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 2 - 80)
                    : null,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 130,
                  transform: Matrix4.skewY(0.04),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    gradient: LinearGradient(
                      colors: [
                        professionsArray[index]["colors"][0],
                        professionsArray[index]["colors"][1],
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: <BoxShadow>[
                      if (_tapped != null && _tapped == index)
                        BoxShadow(
                          color: professionsArray[index]["colors"][0]
                              .withOpacity(0.4),
                          blurRadius: 5,
                          offset: Offset(
                            0,
                            0,
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 150,
                    height: 130,
                    padding: EdgeInsets.all(30),
                    child: Text(
                      professionsArray[index]["name"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                if (_tapped != null && _tapped == index)
                  Positioned(
                    top: 10,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF008000),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 15,
                            offset: Offset(-5, 2),
                            color: Color(0xFF008000),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
