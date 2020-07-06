// Packages
import 'package:flutter/material.dart';

// Views
import './views/home.dart';

// Utils
import 'utils/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Bucket Design.',
      theme: ThemeData(
        fontFamily: "Manrope",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: CustomTheme.background,
        canvasColor: CustomTheme.background,
      ),
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) => Home(),
      },
    );
  }
}
