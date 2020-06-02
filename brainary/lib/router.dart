import 'package:brainary/landing_tab/landing_tab.dart';
import 'package:brainary/signup/signup.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignUp.PATH:
      return MaterialPageRoute(builder: (context) => SignUp());
    case LandingTab.PATH:
      return MaterialPageRoute(builder: (context) => LandingTab());
    default:
      return MaterialPageRoute(builder: (context) => SignUp());
  }
}