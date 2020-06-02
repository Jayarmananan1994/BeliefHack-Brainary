import 'package:brainary/commons/constants.dart';
import 'package:brainary/model/BrainaryUser.dart';
import 'package:brainary/service/auth_service.dart';
import 'package:brainary/service_locator.dart';
import 'package:flutter/material.dart';

class LandingTab extends StatefulWidget {
  static const PATH = '/LandingTab';

  @override
  _LandingTabState createState() => _LandingTabState();
}

class _LandingTabState extends State<LandingTab> {
  BrainaryUser currentUser;

  AuthService _authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    currentUser= _authService.getCurrentSignedInUser();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appTitle(context),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
          child: Image.asset(MINI_LOGO_IMAGE_PATH),
        ),
      ),
      body: Center(
        child: Text('Tab comes here'),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.book),
          title: new Text('Messages'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        )
      ]),
    );
  }

  appTitle(context) {
    return Column(
      children: <Widget>[
        Text('BELIEFHACK BRAINARY',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        Text(currentUser.name,
            style: TextStyle(color: Colors.grey, fontSize: 15))
      ],
    );
  }
}
