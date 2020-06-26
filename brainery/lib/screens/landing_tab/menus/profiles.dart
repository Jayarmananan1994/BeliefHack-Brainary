import 'package:brainery/commons/constants.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/screens/landing_tab/menus/about_leon.dart';
import 'package:brainery/screens/landing_tab/menus/help.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  static const String PATH = '/profile';
  static TextStyle _primaryTextStyle;
  static List<ProfileOptions> moreOptions = [
    ProfileOptions('About', ''),
    ProfileOptions('About Leon Morton', AboutLeon.PATH),
    ProfileOptions('Terms', ''),
    ProfileOptions('Privacy', ''),
    ProfileOptions('Help', Help.PATH)
  ];

  static List settingsOptions = [
    ProfileOptions('Notifications', ''),
    ProfileOptions('Subscriptions', '')
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
        //padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _pageTitle(),
            _profileInfo(),
            SizedBox(height: 20),
            _moreMenus(),
            _settingsOptions()
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
            print(data.toMap());
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
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                  title: Text('MORE', style: _primaryTextStyle), dense: true);
            } else {
              return ListTile(
                  dense: true,
                  title: Text(moreOptions[index - 1].optionName,
                      style: _primaryTextStyle),
                  trailing: Icon(Icons.arrow_forward_ios), onTap: (){
                    Navigator.of(context).pushNamed(moreOptions[index-1].actionPath);
                  });
            }
          },
          separatorBuilder: (context, index) =>
              Divider(thickness: 1, indent: 15, endIndent: 15),
          itemCount: moreOptions.length + 1),
    );
  }

  _settingsOptions() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                  title: Text('SETTINGS', style: _primaryTextStyle),
                  dense: true);
            } else {
              return ListTile(
                  dense: true,
                  title: Text(settingsOptions[index - 1].optionName,
                      style: _primaryTextStyle),
                  trailing: Icon(Icons.arrow_forward_ios));
            }
          },
          separatorBuilder: (context, index) =>
              Divider(thickness: 1, indent: 15, endIndent: 15),
          itemCount: settingsOptions.length + 1),
    );
  }
}

class ProfileOptions {
  String optionName;
  String actionPath;
  ProfileOptions(this.optionName, this.actionPath);
}
