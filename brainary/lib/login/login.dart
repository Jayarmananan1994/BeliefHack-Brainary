import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false, passwordVisible = true;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: [
                    emailField(),
                    passwordField(),
                    SizedBox(height: 60),
                    buttonPanel()
                  ],
                ))));
  }

  emailField() {}

  passwordField() {}

  buttonPanel() {}
}
