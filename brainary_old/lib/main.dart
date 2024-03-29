import 'package:brainary/commons/constants.dart';
import 'package:brainary/screens/splash_screen/splash_screen.dart';
import 'package:brainary/service_locator.dart';
import 'package:flutter/material.dart';

import 'router.dart' as router;

String appUid, appUserName;
void main() async {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(LOGO_IMAGE_PATH), context);
    precacheImage(AssetImage(SPLASH_SCREEN_IMAGE), context);
    return MaterialApp(
      title: 'Brainary',
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
        primarySwatch: MaterialColor(0xff315192, colorSwatchMap), //Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.PATH,
      debugShowCheckedModeBanner: false,
    );
  }
}
