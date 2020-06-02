import 'package:brainary/commons/constants.dart';
import 'package:brainary/signup/signup_form.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  static const PATH = '/signup';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double _height;
  ImageProvider logoImage = AssetImage(LOGO_IMAGE_PATH);

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [logo(), SignupForm()],
          ),
        ),
      ),
    );
  }

  logo() {
    return Container(
      padding: EdgeInsets.all(25),
      height: _height * 0.3,
      child: Image(image: logoImage),
    );
  }
}
