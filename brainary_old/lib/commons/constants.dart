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

const String LOGO_IMAGE_PATH = 'assets/images/brainary_logo.jpg';
const MINI_LOGO_IMAGE_PATH = 'assets/images/logo-mini.jpg';
const SPLASH_SCREEN_IMAGE = 'assets/images/splash.jpg';
const LOADING_IMAGE_PATH = 'assets/images/loading.gif';
const INTRO_VIDEO_URL = 'https://firebasestorage.googleapis.com/v0/b/brainary-c9576.appspot.com/o/vipifoziwkb?alt=media&token=98f55549-bab3-4a1a-8fc4-08947f5d0784';

const DEFAULT_SERVICE_ERROR = 'We are not able to handle your request right now. \n Please try after sometime';
const INVALID_CREDENTIAL = 'Incorrect emailId or password';