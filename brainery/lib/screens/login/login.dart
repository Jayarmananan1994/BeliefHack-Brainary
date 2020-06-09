import 'package:brainery/commons/constants.dart';
import 'package:brainery/commons/ui/error_dialog.dart';
import 'package:brainery/commons/validators.dart';
import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:brainery/screens/signup/signup.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  static const String PATH = '/signin';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String emailVal, passwordVal;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false, passwordVisible = true;
  AuthService _authService = locator<AuthService>();
  double _height, _width;
  ImageProvider logoImage = AssetImage(LOGO_IMAGE_PATH);

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [logo(), loginForm()],
            ),
          ),
        ));
  }

  loginForm() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: [
                emailField(),
                passwordField(),
                SizedBox(height: _height * 0.3),
                buttonPanel()
              ],
            )));
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
      icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey),
      onPressed: () {
        setState(() {
          passwordVisible = !passwordVisible;
        });
      },
    );
  }

  buttonPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        signinButton(),
        SizedBox(height: 25),
        lineDecoration(),
        SizedBox(height: 25),
        options()
      ],
    );
  }

  signinButton() {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: confirmSignin,
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
            constraints: BoxConstraints(maxWidth: 500.0, minHeight: 100.0),
            alignment: Alignment.center,
            child: Text(
              "APPLY",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
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

  void confirmSignin() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _authService.signinWithEmail(emailVal, passwordVal).then((value) {
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

  lineDecoration() {
    return Container(
      height: 1,
      width: _width * 0.6,
      color: Colors.blueGrey,
    );
  }

  options() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      InkWell(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('Register')),
          onTap: () => Navigator.pushNamed(context, SignUp.PATH)),
      Container(
          width: 2,
          height: 10,
          color: Colors.blueGrey,
          padding: EdgeInsets.symmetric(horizontal: 10)),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Forgot Your Password ?'),
      )
    ]);
  }

  signupErrorHandler(error) {
    if (error is PlatformException) {
      PlatformException pError = error;
      if ('ERROR_USER_NOT_FOUND' == pError.code ||
          'ERROR_WRONG_PASSWORD' == pError.code) {
        showErrorDialogue(INVALID_CREDENTIAL);
      } else {
        showErrorDialogue(DEFAULT_SERVICE_ERROR);
      }
    } else {
      showErrorDialogue(DEFAULT_SERVICE_ERROR);
    }
  }

  showErrorDialogue(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return ErrorDialogue(errorMsg: errorMessage);
        });
  }
}
