
import 'package:brainery/screens/apptour/tour_page.dart';
import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:brainery/screens/login/login.dart';
import 'package:brainery/screens/signup/signup.dart';
import 'package:brainery/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

const String ROOT_PATH = '/';

 Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignUp.PATH:
      return MaterialPageRoute(builder: (context) => SignUp());
    case LandingTab.PATH:
      return MaterialPageRoute(builder: (context) => LandingTab());
    case Login.PATH:
      return MaterialPageRoute(builder: (context) => Login());
    case SplashScreen.PATH:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case TourPage.PATH:
      var controller = settings.arguments;
      return MaterialPageRoute(builder: (context) => TourPage(controller: controller,));
    default:
      return MaterialPageRoute(builder: (context) => SignUp());
  }
}