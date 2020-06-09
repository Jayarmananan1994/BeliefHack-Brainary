import 'package:brainery/commons/constants.dart';
import 'package:brainery/screens/apptour/tour_page.dart';
import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:brainery/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  static const String PATH = '/splashscreen';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    navigateUserBasedOnState(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff2469c6),
      body: getSplashScreen(width),
    );
  }

  navigateUserBasedOnState(context) async {
    SharedPreferences _preference = await SharedPreferences.getInstance();
    bool isAppTourDone = _preference.getBool('appTour');

    if (isAppTourDone == null) {
      final VideoPlayerController _controller =
          VideoPlayerController.network(INTRO_VIDEO_URL);
      _controller.initialize().then((value) {
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, TourPage.PATH, (r) => false,
            arguments: _controller);
      });
    } else {
      _firebaseAuth.currentUser().then((value) {
        String path = (value == null) ? Login.PATH : LandingTab.PATH;
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, path, (r) => false);
      }).catchError((e) {
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, Login.PATH, (r) => false);
      });
    }
  }

  getSplashScreen(width) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(SPLASH_SCREEN_IMAGE), fit: BoxFit.cover)),
      ),
      Positioned(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
        bottom: 75,
        left: width * 0.5,
      )
    ]);
  }
}
