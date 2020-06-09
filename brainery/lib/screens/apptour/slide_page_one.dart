
import 'package:brainery/commons/constants.dart';
import 'package:brainery/screens/apptour/intro_video_player.dart';
import 'package:brainery/screens/apptour/skip_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SlidePageOne extends StatefulWidget {
  final VideoPlayerController controller;
  SlidePageOne({@required this.controller});

  @override
  _SlidePageOneState createState() => _SlidePageOneState();
}

class _SlidePageOneState extends State<SlidePageOne> {
  TextStyle _defaultTextStyle = TextStyle(color: Color(0xff8b97bc));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: <Widget>[
            SkipButton(),
            logo(),
            SizedBox(height: 20),
            ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: IntroVideoPlayer(controller: widget.controller)),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('Welcome to the',
                    style: TextStyle(color: Color(0xff8b97bc), fontSize: 30))),
            Text('Brainery!',
                style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            decoration(),
            SizedBox(height: 20),
            Text('Please start with the short message', style: _defaultTextStyle),
            Text('about how to best benefit from the',style: _defaultTextStyle),
            Text('Brainery app', style: _defaultTextStyle)

          ],
        ),
      ),
    );
  }

  logo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Image(
            width: 75, height: 75, image: AssetImage(MINI_LOGO_IMAGE_PATH)),
      ),
    );
  }

  decoration() {
    return Center(
      child: Container(
        color: Colors.blue,
        height: 10,
        width: 50,
      ),
    );
  }
}
