import 'dart:io';

import 'package:brainery/commons/constants.dart';
import 'package:brainery/commons/ui/brainery_alert_dialog.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/screens/landing_tab/menus/about_leon.dart';
import 'package:brainery/screens/landing_tab/menus/faq.dart';
import 'package:brainery/screens/landing_tab/menus/help.dart';
import 'package:brainery/screens/landing_tab/menus/privacy.dart';
import 'package:brainery/screens/landing_tab/menus/subscription_info.dart';
import 'package:brainery/screens/landing_tab/menus/terms.dart';
import 'package:brainery/screens/login/login.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service/brainery_user_service.dart';
import 'package:brainery/service/firebase_auth_service.dart';
import 'package:brainery/service/lesson_and_course_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Profile extends StatefulWidget {
  static const String PATH = '/profile';
  static TextStyle _primaryTextStyle;
  static List<ProfileOptions> moreOptions = [
    ProfileOptions('More', 'title'),
    ProfileOptions('About', ''),
    ProfileOptions('About Leon Morton', AboutLeon.PATH),
    ProfileOptions('Terms', Terms.PATH),
    ProfileOptions('Faq', Faq.PATH),
    ProfileOptions('Privacy', Privacy.PATH),
    ProfileOptions('Help', Help.PATH),
    ProfileOptions('SETTINGS', 'title'),
    ProfileOptions('Notifications', ''),
    ProfileOptions('Subscription', SubscriptionInfo.PATH),
    ProfileOptions('Sign out', 'logout')
  ];

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _authService = locator<AuthService>();
  final BraineryUserService _userService = locator<BraineryUserService>();
  final FireBaseAuthService _fireBaseAuthService = locator<AuthService>();
  final LessonAndCourseService _lessonAndCourseService =
      locator<LessonAndCourseService>();
  final ImageProvider defaultProvider = AssetImage(PROFILE_IMAGE_PATH);
  ImageProvider profileImageProvider = AssetImage(PROFILE_IMAGE_PATH);
  BuildContext _context;

  @override
  void initState() {
    updateProfileImage();
    super.initState();
  }

  updateProfileImage() async {
    var user = await _userService.getCurrentUser();
    if (user.profileImage != null && user.profileImage.isNotEmpty) {
      setState(() {
        profileImageProvider = NetworkImage(user.profileImage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    var _themeColor = Theme.of(context).primaryColor;
    Profile._primaryTextStyle = TextStyle(
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
        child: Text('PROFILE', style: Profile._primaryTextStyle));
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
              Text(data.name, style: Profile._primaryTextStyle),
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
      child: GestureDetector(
        onTap: () async {
          FilePickerResult result = await FilePicker.platform.pickFiles();
          if (result != null) {
            File file = File(result.files.single.path);
            print(file.path);
            setState(() {
              profileImageProvider = FileImage(file);
            });

            var dialogRef = showConfirmationDialog();
            dialogRef.then((value) {
              print(value);
              if (value) {
                uploadNewProfile(file);
              } else {
                setState(() {
                  profileImageProvider = defaultProvider;
                });
              }
            });
          }
        },
        child: Container(
          width: 90,
          height: 90,
          padding: EdgeInsets.only(top: 70, left: 5),
          decoration: BoxDecoration(
              color: Colors.grey,
              image: DecorationImage(
                  image: profileImageProvider, fit: BoxFit.cover)),
          child: Text('Change photo',
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ),
    );
  }

  _moreMenus() {
    return ListView.separated(
        itemBuilder: (context, index) {
          var option = Profile.moreOptions[index];
          if (option.actionPath == 'title') {
            return ListTile(
                title:
                    Text(option.optionName, style: Profile._primaryTextStyle),
                dense: true);
          } else {
            return ListTile(
                dense: true,
                title:
                    Text(option.optionName, style: Profile._primaryTextStyle),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => menuAction(option, context));
          }
        },
        separatorBuilder: (context, index) =>
            Divider(thickness: 1, indent: 15, endIndent: 15),
        itemCount: Profile.moreOptions.length);
  }

  menuAction(ProfileOptions option, context) {
    if (option.actionPath == 'logout') {
      _authService.signout();
      _lessonAndCourseService.clearLessonCache();
      _userService.clearUserCacheInfo();
      Navigator.pushNamedAndRemoveUntil(context, Login.PATH, (r) => false);
    } else if (option.actionPath == '') {
      // Ignore the action
    } else {
      Navigator.of(context).pushNamed(option.actionPath);
    }
  }

  Future<bool> showConfirmationDialog() {
    return showDialog(
        context: _context,
        child: BraineryAlertDialog(
            title: 'Confirmation!',
            content: 'Would you like to set this as your profile picture?',
            confirmText: 'Yes',
            cancelText: 'No'));
  }

  void uploadNewProfile(File profilePic) async {
    var snapshot =
        await _fireBaseAuthService.uploadFile('profileImages', profilePic);
    if (snapshot.error == null) {
      String profilePicUrl = await snapshot.ref.getDownloadURL();
      print(profilePicUrl);
      setState(() {
        profileImageProvider = NetworkImage(profilePicUrl);
      });
      _userService.uploadProfileImage(profilePicUrl).then((value) {
        print(value);
      });
    }
    //_userService.uploadProfileImage(profilePic);
  }
}

class ProfileOptions {
  String optionName;
  String actionPath;
  ProfileOptions(this.optionName, this.actionPath);
}
