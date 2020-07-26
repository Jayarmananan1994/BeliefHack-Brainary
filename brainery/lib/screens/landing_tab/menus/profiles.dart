import 'package:brainery/commons/constants.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/screens/landing_tab/menus/about_leon.dart';
import 'package:brainery/screens/landing_tab/menus/help.dart';
import 'package:brainery/screens/login/login.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  static const String PATH = '/profile';
  static TextStyle _primaryTextStyle;
  static List<ProfileOptions> moreOptions = [
    ProfileOptions('More', 'title'),
    ProfileOptions('About', ''),
    ProfileOptions('About Leon Morton', AboutLeon.PATH),
    ProfileOptions('Terms', ''),
    ProfileOptions('Privacy', ''),
    ProfileOptions('Help', Help.PATH),
    ProfileOptions('SETTINGS', 'title'),
    ProfileOptions('Notifications', ''),
    ProfileOptions('Subscription', ''),
    ProfileOptions('Sign out', 'logout')
  ];

  static List settingsOptions = [
    ProfileOptions('Notifications', ''),
    ProfileOptions('Subscription', ''),
    ProfileOptions('Sign out', 'logout')
  ];

  final AuthService _authService = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    var _themeColor = Theme.of(context).primaryColor;
    _primaryTextStyle = TextStyle(
        color: _themeColor, fontSize: 16, fontWeight: FontWeight.w800);
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILE'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _pageTitle(),
            _profileInfo(),
            SizedBox(height: 20),
            Flexible(child: _moreMenus())
          ],
        ),
      ),
    );
  }

  _pageTitle() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Text('PROFILE', style: _primaryTextStyle));
  }

  _profileInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: <Widget>[
          _profileImage(),
          _userInfo(),
        ],
      ),
    );
  }

  _userInfo() {
    return FutureBuilder<BraineryUser>(
        future: _authService.getCurrentSignedInUser(),
        builder: (context, snapshot) {
          List<Widget> widgets;
          if (snapshot.hasData) {
            var data = snapshot.data;
            widgets = [
              Text(data.name, style: _primaryTextStyle),
              Text(data.emailId)
            ];
          } else {
            widgets = [
              Container(height: 10, color: Colors.black),
              Container(height: 10, color: Colors.grey)
            ];
          }
          return Container(
            height: 80,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: widgets,
            ),
          );
        });
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 90,
        height: 90,
        padding: EdgeInsets.only(top: 70, left: 5),
        decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
                image: AssetImage(PROFILE_IMAGE_PATH), fit: BoxFit.cover)),
        child: Text('Change photo',
            style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }

  _moreMenus() {
    return ListView.separated(
        itemBuilder: (context, index) {
          var option = moreOptions[index];
          if (option.actionPath == 'title') {
            return ListTile(
                title: Text(option.optionName, style: _primaryTextStyle),
                dense: true);
          } else {
            return ListTile(
                dense: true,
                title: Text(option.optionName, style: _primaryTextStyle),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => menuAction(option, context));
          }
        },
        separatorBuilder: (context, index) =>
            Divider(thickness: 1, indent: 15, endIndent: 15),
        itemCount: moreOptions.length);
  }

  menuAction(ProfileOptions option, context) {
    if (option.actionPath == 'logout') {
      _authService.signout();
      Navigator.pushNamedAndRemoveUntil(context, Login.PATH, (r) => false);
    }else if(option.actionPath==''){
      // Ignore the action
    } else {
       Navigator.of(context).pushNamed(option.actionPath);
    }
  }
}

class ProfileOptions {
  String optionName;
  String actionPath;
  ProfileOptions(this.optionName, this.actionPath);
}
