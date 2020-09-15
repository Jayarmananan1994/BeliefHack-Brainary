import 'package:brainery/model/BraineryCourse.dart';
import 'package:brainery/screens/apptour/tour_page.dart';
import 'package:brainery/screens/course_list/course_list.dart';
import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:brainery/screens/landing_tab/menus/about_leon.dart';
import 'package:brainery/screens/landing_tab/menus/faq.dart';
import 'package:brainery/screens/landing_tab/menus/help.dart';
import 'package:brainery/screens/landing_tab/menus/privacy.dart';
import 'package:brainery/screens/landing_tab/menus/profiles.dart';
import 'package:brainery/screens/landing_tab/menus/reminder.dart';
import 'package:brainery/screens/landing_tab/menus/subscription_info.dart';
import 'package:brainery/screens/landing_tab/menus/terms.dart';
import 'package:brainery/screens/landing_tab/timer/timer_start.dart';
import 'package:brainery/screens/login/login.dart';
import 'package:brainery/screens/passwordreset/password_reset.dart';
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
      Map arg = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PaypalSubscription(
              onFinish: arg['onFinish'], planId: arg['planId']));
    case CourseList.PATH:
      BraineryCourse course = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => CourseList(braineryCourse: course));
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
    case Faq.PATH:
      return MaterialPageRoute(builder: (context) => Faq());
    case Terms.PATH:
      return MaterialPageRoute(builder: (context) => Terms());
    case Privacy.PATH:
      return MaterialPageRoute(builder: (context) => Privacy());
     case Remnider.PATH:
      return MaterialPageRoute(builder: (context) => Remnider());
    case PasswordReset.PATH:
      return MaterialPageRoute(builder: (context)=> PasswordReset());
    case SubscriptionInfo.PATH:
      return MaterialPageRoute(builder: (context) => SubscriptionInfo());
    case TimerStart.PATH:
      Map arg = settings.arguments;
      return MaterialPageRoute(builder: (context) => TimerStart(totalSeconds: arg['totalSeconds'], interval: arg['interval'],));
    case TourPage.PATH:
      var controller = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => TourPage(controller: controller));
    default:
      return MaterialPageRoute(builder: (context) => SignUp());
  }
}
