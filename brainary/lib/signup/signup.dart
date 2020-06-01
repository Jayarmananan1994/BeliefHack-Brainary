import 'package:brainary/signup/signup_form.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double _height;
  @override
  Widget build(BuildContext context) {
    //_width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [logo(), SignupForm()],
        ),
      ),
    );
  }

  logo() {
    return Container(
      height: _height * 0.3,
      child: Image.asset('assets/images/BeliefHack_Brainery_logo.jpg'),
    );
  }
}
