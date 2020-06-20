import 'package:brainery/commons/my_flutter_app_icons.dart';
import 'package:brainery/commons/constants.dart';
import 'package:brainery/screens/apptour/skip_button.dart';
import 'package:flutter/material.dart';

class SlidePageTwo extends StatelessWidget {
  final defaultTextStyle = TextStyle(color: Color(0xff8b97bc), fontSize: 17);
  final boldStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SkipButton(buttonText: 'Done'),
            _logo(),
            //SizedBox(height: 20),
            _instructionOne(),
            //SizedBox(height: 20),
            _instructionTwo(),
            //SizedBox(height: 20),
            _instructionThree(),
            //SizedBox(height: height * 0.08),
            decorationLine(width),
            _facebookIcon()
          ],
        ),
      ),
    );
  }

  _instructionOne() {
    return _createInstruction(
        "1",
        Text("Our ease of use press and play\nfunctionality is intuitive",
            style: defaultTextStyle));
  }

  _instructionTwo() {
    var instruction = RichText(
        text: TextSpan(text: 'Simply ', style: defaultTextStyle, children: [
      TextSpan(text: 'press ', style: boldStyle),
      TextSpan(text: 'the '),
      TextSpan(text: 'play button ', style: boldStyle),
      TextSpan(text: 'on\n'),
      TextSpan(text: 'each course or lesson which will\n'),
      TextSpan(text: 'open the course or lesson\n'),
      TextSpan(text: 'individual page. Simply press\n'),
      TextSpan(text: 'play for each lesson as you desire.\n'),
      TextSpan(text: 'If you would like to'),
      TextSpan(text: 'favorite ', style: boldStyle),
      TextSpan(text: 'any\n'),
      TextSpan(text: 'lesson simply press the '),
      TextSpan(text: 'heart\n', style: boldStyle),
      TextSpan(text: 'button', style: boldStyle),
      TextSpan(text: ', and to '),
      TextSpan(text: 'download ', style: boldStyle),
      TextSpan(text: 'a\n'),
      TextSpan(text: 'lesson simply click the '),
      TextSpan(text: 'download\n', style: boldStyle),
      TextSpan(text: 'button ', style: boldStyle),
      TextSpan(text: 'associated with that\n'),
      TextSpan(text: 'lesson.'),
    ]));
    return _createInstruction("2", instruction);
  }

  _instructionThree() {
    var instruction = RichText(
        text: TextSpan(
            text: 'If you like to join our\n',
            style: defaultTextStyle,
            children: [
          TextSpan(text: 'FaceBook Group ', style: boldStyle),
          TextSpan(text: 'community\n'),
          TextSpan(text: 'simply press the Facebook Group\n'),
          TextSpan(text: 'button and follow enter you\n'),
          TextSpan(text: 'facebook information.')
        ]));
    return _createInstruction("3", instruction);
  }

  _createInstruction(String number, Widget instruction) {
    return Row(
      children: <Widget>[
        Container(
            child: Text(number,
                style: TextStyle(color: Colors.blue, fontSize: 45)),
            padding: EdgeInsets.symmetric(horizontal: 45)),
        instruction
      ],
    );
  }

  _logo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child:
            Image(width: 200, height: 100, image: AssetImage(LOGO_IMAGE_PATH)),
      ),
    );
  }

  decorationLine(width) {
    return Container(
      height: 2,
      color: Colors.grey,
      width: width * 0.85,
    );
  }

  _facebookIcon() {
    return Container(
      margin: EdgeInsets.all(30),
        child: RaisedButton(
            onPressed: () {},
            color: Colors.blue,
            child: Icon(MyFlutterAppIcons.facebook),
            ));
  }
}
