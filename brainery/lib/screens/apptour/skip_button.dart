import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:brainery/screens/signup/signup.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkipButton extends StatelessWidget {
  final String buttonText;
  final AuthService _authService = locator<AuthService>();

  SkipButton({@required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      RawMaterialButton(
          onPressed: () async {
            SharedPreferences _sharedPreferences =
                await SharedPreferences.getInstance();
            _sharedPreferences.setBool('appTour', true);
            _authService.getCurrentSignedInUser().then((value) {
              var pathToGo = (value == null) ? SignUp.PATH : LandingTab.PATH;
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, pathToGo, (r) => false);
            });
          },
          child: Text( buttonText, style: TextStyle(color: Colors.white)))
    ]);
  }
}
