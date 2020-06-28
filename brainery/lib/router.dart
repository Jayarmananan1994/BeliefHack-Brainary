import 'package:brainery/screens/apptour/tour_page.dart';
import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:brainery/screens/landing_tab/menus/about_leon.dart';
import 'package:brainery/screens/landing_tab/menus/help.dart';
import 'package:brainery/screens/landing_tab/menus/profiles.dart';
import 'package:brainery/screens/login/login.dart';
import 'package:brainery/screens/payment/payment.dart';
import 'package:brainery/screens/payment/payment_error.dart';
import 'package:brainery/screens/payment/payment_success.dart';
import 'package:brainery/screens/payment/paypal_payment.dart';
import 'package:brainery/screens/payment/paypal_subscription.dart';
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
    case PaypalPayment.PATH:
      var onFinish = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PaypalPayment(onFinish: onFinish));
    case PaypalSubscription.PATH:
      var onFinish = settings.arguments;
      return MaterialPageRoute(builder: (context) => PaypalSubscription(onFinish: onFinish));
    case Payment.PATH:
      return MaterialPageRoute(builder: (context) => Payment());
    case PaymentSucess.PATH:
      return MaterialPageRoute(builder: (context) => PaymentSucess());
    case PaymentError.PATH:
      return MaterialPageRoute(builder: (context) => PaymentError());
    case Profile.PATH:
      return MaterialPageRoute(builder: (context) => Profile());
    case AboutLeon.PATH:
      return MaterialPageRoute(builder: (context) => AboutLeon());
    case Help.PATH:
      return MaterialPageRoute(builder: (context) => Help());
    case TourPage.PATH:
      var controller = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => TourPage(controller: controller));
    default:
      return MaterialPageRoute(builder: (context) => SignUp());
  }
}
