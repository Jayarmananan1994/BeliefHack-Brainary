import 'package:brainery/screens/signup/signup.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class BraineryDrawer extends StatelessWidget {
  final List<String> menus = ["Profile", "Account", "Reminder", "Subscription"];
  final AuthService _authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerItems = [getDrawerHeader(context)];
    drawerItems.addAll(menus.map((e) => createMenu(e, context)).toList());

    return Drawer(
        child: SafeArea(
      child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: drawerItems),
    ));
  }

  getDrawerHeader(context) {
    var primarycolor = Theme.of(context).primaryColor;
    return Material(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('MENU',
              style: TextStyle(
                  color: primarycolor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
          IconButton(
              icon: Icon(Icons.close, size: 30, color: primarycolor),
              onPressed: () => Navigator.pop(context))
        ]),
      ),
    );
  }

  Widget createMenu(String menu, context) {
    return ListTile(
      title: Text(menu),
      onTap: () {
        _authService.signout().then((value) {
          Navigator.pushNamed(context, SignUp.PATH);
        })
            //Navigator.pop(context);
            ;
      },
    );
  }

 
}
