import 'package:flutter/material.dart';

Map<int, Color> colorSwatchMap =
{
50:Color.fromRGBO(136,14,79, .1),
100:Color.fromRGBO(136,14,79, .2),
200:Color.fromRGBO(136,14,79, .3),
300:Color.fromRGBO(136,14,79, .4),
400:Color.fromRGBO(136,14,79, .5),
500:Color.fromRGBO(136,14,79, .6),
600:Color.fromRGBO(136,14,79, .7),
700:Color.fromRGBO(136,14,79, .8),
800:Color.fromRGBO(136,14,79, .9),
900:Color.fromRGBO(136,14,79, 1),
};

getColorSwatch(){
  return colorSwatchMap;
}

const String LOGO_IMAGE_PATH = 'assets/images/brainery_logo.png';
const String LOGO_IMAGE_BLUE_PATH = 'assets/images/brainery_logo.jpg';
const MINI_LOGO_IMAGE_PATH = 'assets/images/logo-mini.png';
const SPLASH_SCREEN_IMAGE = 'assets/images/splash.jpg';
const LOADING_IMAGE_PATH = 'assets/images/loading.gif';
const PROFILE_IMAGE_PATH = 'assets/images/profile-icon.png';
const INTRO_VIDEO_URL = 'https://firebasestorage.googleapis.com/v0/b/brainary-c9576.appspot.com/o/vipifoziwkb?alt=media&token=98f55549-bab3-4a1a-8fc4-08947f5d0784';
const INTRO_VIDEO_THUMBNAIL = 'https://firebasestorage.googleapis.com/v0/b/brainary-c9576.appspot.com/o/into_preview.jpg?alt=media&token=37660994-c7e2-4e1a-887e-40ff3454a385';
const DEFAULT_SERVICE_ERROR = 'We are not able to handle your request right now. \n Please try after sometime';
const INVALID_CREDENTIAL = 'Incorrect emailId or password';
const SQUARE_PAY_APPLICATION_ID = 'sandbox-sq0idb-NtWG2AYYf30z08rCydi4TQ';
const SQUARE_PAY_SERVICE_URL = 'https://beliefhackbrainery-dev.herokuapp.com/chargeForCookie';