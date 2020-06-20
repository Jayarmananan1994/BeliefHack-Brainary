import 'package:brainery/commons/ui/loading_spinner.dart';
import 'package:brainery/commons/validators.dart';
import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String nameVal, emailVal, passwordVal;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false, passwordVisible = true;
  AuthService _authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: [
                nameField(),
                emailField(),
                passwordField(),
                SizedBox(height: 60),
                signupButton()
              ],
            )));
  }

  nameField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: 'Enter your name'),
      onSaved: (val) => nameVal = val,
      validator: validateName,
    );
  }

  emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: 'Enter email address'),
      onSaved: (val) => emailVal = val,
      validator: validateEmail,
    );
  }

  passwordField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: passwordVisible,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: passwordVisibleIcon(),
      ),
      onSaved: (val) => passwordVal = val,
      validator: validatePassword,
    );
  }

  passwordVisibleIcon() {
    return IconButton(
      icon: Icon(
        passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          passwordVisible = !passwordVisible;
        });
      },
    );
  }

  signupButton() {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: confirmSignup,
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

  confirmSignup() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showLoadingDialog();
      _authService
          .createNewUserWithEmail(emailVal, passwordVal, nameVal)
          .then((value) {
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, LandingTab.PATH, (r) => false);
      }).catchError(signupErrorHandler);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  signupErrorHandler(error) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Card(
                child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: 300,
              //height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Oops!',
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor)),
                  SizedBox(height: 5),
                  Text('We are not able to handle your request right now.'),
                  RaisedButton(
                      onPressed: () => Navigator.pop(context),
                      color: Theme.of(context).primaryColor,
                      child: Text('Okay', style: TextStyle(color: Colors.white),))
                ],
              ),
            )),
          );
        });
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 100,
            child: Center(
                child: Row(
              children: <Widget>[
                LoadingSpinner(radius: 15.0, dotRadius: 5.0),
                Text('Please hold on.'),
              ],
            )),
          ),
        );
      },
    );
  }
}
