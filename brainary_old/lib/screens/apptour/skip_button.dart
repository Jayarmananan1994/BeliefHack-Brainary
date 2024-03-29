import 'package:brainary/screens/landing_tab/landing_tab.dart';
import 'package:brainary/screens/signup/signup.dart';
import 'package:brainary/service/auth_service.dart';
import 'package:brainary/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkipButton extends StatelessWidget {
  final AuthService _authService = locator<AuthService>();
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
          child: Text('Skip', style: TextStyle(color: Colors.white)))
    ]);
  }
}
