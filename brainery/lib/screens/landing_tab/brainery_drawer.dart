import 'package:brainery/screens/landing_tab/menus/profiles.dart';
import 'package:brainery/screens/payment/payment.dart';
import 'package:flutter/material.dart';

class BraineryDrawer extends StatelessWidget {
  final List<BraineryMenu> menus = [
    BraineryMenu("Profile", Profile.PATH),
    BraineryMenu("Account", Profile.PATH),
    BraineryMenu("Reminder", Profile.PATH),
    BraineryMenu("Subscriptions", Payment.PATH)
  ];

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

  Widget createMenu(BraineryMenu menu, context) {
    return ListTile(
      title: Text(menu.menuName),
      onTap: () => Navigator.of(context).pushNamed(menu.actionWidget)
      );
            //Navigator.pop(context)
  }
}

class BraineryMenu {
  String menuName;
  String actionWidget;
  BraineryMenu(this.menuName, this.actionWidget);
}
