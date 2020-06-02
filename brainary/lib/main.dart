import 'package:brainary/commons/constants.dart';
import 'package:brainary/landing_tab/landing_tab.dart';
import 'package:brainary/service_locator.dart';
import 'package:brainary/signup/signup.dart';
import 'package:flutter/material.dart';
import 'router.dart' as router;
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     precacheImage(AssetImage(LOGO_IMAGE_PATH), context);
    return MaterialApp(
      title: 'Brainary',
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff315192, colorSwatchMap), //Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SignUp.PATH,
      debugShowCheckedModeBanner: false,
    );
  }
}
