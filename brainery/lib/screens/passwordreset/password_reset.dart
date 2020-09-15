import 'package:brainery/commons/constants.dart';
import 'package:brainery/commons/ui/brainery_alert_dialog.dart';
import 'package:brainery/commons/ui/error_dialog.dart';
import 'package:brainery/commons/ui/loading_spinner.dart';
import 'package:brainery/screens/login/login.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service/firebase_auth_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:brainery/commons/validators.dart';

class PasswordReset extends StatelessWidget {
  static const PATH = '/password-reset';
  double _height;
  String emailVal;
  ImageProvider logoImage = AssetImage(LOGO_IMAGE_BLUE_PATH);
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  BuildContext _context;
  FireBaseAuthService _fireBaseAuthService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    _context = context;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              logo(),
              resetLinkForm(),

              //signinLink(context)
            ],
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

  resetLinkForm() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: [
                emailField(),
                SizedBox(height: 60),
                sendPasswordResetLinkButton(),
                SizedBox(height: _height * 0.2),
                signinLink(_context)
              ],
            )));
  }

  emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(hintText: 'Enter email addressss'),
      onSaved: (val) => emailVal = val,
      validator: validateEmail,
    );
  }

  sendPasswordResetLinkButton() {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: sendPasswordResetLink,
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

  void sendPasswordResetLink() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showLoadingDialog();
      print(">>>>>>>>");
      print(emailVal);
      _fireBaseAuthService.sendPasswordResetEmail(emailVal).then((value) {
        Navigator.of(_context).pop();
         return showDialog(
        context: _context,
        child: BraineryAlertDialog(
            title: 'Done!',
            content: 'A password reset link has been sent to your email.',
            confirmText: 'Ok'));
      }).catchError((error) {
        Navigator.of(_context).pop();
        showErrorDialogue(DEFAULT_SERVICE_ERROR);
      });
    }
  }

  signinLink(context) {
    return new InkWell(
        child: Text('Go back to Sign in.',
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.blueGrey)),
        onTap: () {
          Navigator.pushNamed(context, Login.PATH);
        });
  }

  showLoadingDialog() {
    showDialog(
      context: _context,
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
                Text('Please hold on'),
              ],
            )),
          ),
        );
      },
    );
  }

  showErrorDialogue(String errorMessage) {
    showDialog(
        context: _context,
        builder: (context) {
          return ErrorDialogue(errorMsg: errorMessage);
        });
  }
}
