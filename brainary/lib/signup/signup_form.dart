import 'package:brainary/commons/validators.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String userNameVal, passwordVal;
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Form(
            child: Column(
          children: [
            userNameField(),
            passwordField(),
            SizedBox(height: 60),
            signupButton()
          ],
        )));
  }

  userNameField() {
    return TextFormField(
      decoration: InputDecoration(hintText: 'Enter email Address'),
      onSaved: (val) => userNameVal = val,
      validator: validateName,
    );
  }

  passwordField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: passwordVisible,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
      onSaved: (val) => passwordVal = val,
    );
  }

  signupButton() {
    /*return Container(
        // height: 25,
        padding: EdgeInsets.symmetric(vertical: 50),
        child: SizedBox(
            height: 50,
            width: double.infinity,
            child: RaisedButton(
              //color: Color(0xff247ae7),
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff247ae7), Color(0xff089ee2)],begin: Alignment.topRight, end: Alignment.bottomLeft)),
                child: Container(
                   constraints: BoxConstraints( minHeight: 50.0),
                  child: Text(
                    'Nexts',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )));*/

    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: () {},
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff247ae7), Color(0xff089ee2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              "Next",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
