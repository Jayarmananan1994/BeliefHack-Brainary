import 'package:brainary/commons/constants.dart';
import 'package:brainary/commons/my_flutter_app_icons.dart';
import 'package:brainary/model/BrainaryUser.dart';
import 'package:brainary/screens/landing_tab/brainary_drawer.dart';
import 'package:brainary/service/auth_service.dart';
import 'package:brainary/service_locator.dart';
import 'package:flutter/material.dart';

class LandingTab extends StatefulWidget {
  static const PATH = '/LandingTab';

  @override
  _LandingTabState createState() => _LandingTabState();
}

class _LandingTabState extends State<LandingTab> {
  BrainaryUser _currentUser;
  AuthService _authService = locator<AuthService>();
  int _selectedTab = 0;
  static const List<Widget> _tabList = [
    Center(child: Text('Home Tab comes here')),
    Center(child: Text('Lesson Tab comes here')),
    Center(child: Text('Course Tab comes here')),
    Center(child: Text('Timer Tab comes here')),
    Center(child: Text('Favoite Tab comes here'))
  ];

  static List<TabMenu> _tabMenus = [
    TabMenu(0, 'HOME', Icons.home),
    TabMenu(1, 'LESSONS', MyFlutterAppIcons.book_open),
    TabMenu(2, 'COURSES', Icons.home),
    TabMenu(3, 'TIMER', MyFlutterAppIcons.clock),
    TabMenu(4, 'FAVORITES', Icons.favorite_border),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appTitle(context),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
          child: Image.asset(MINI_LOGO_IMAGE_PATH),
        ),
        iconTheme: IconThemeData(color: Color(0xff3e5276)),
      ),
      body: _tabList[_selectedTab],
      endDrawer: BrainaryDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: _selectedTab,
        selectedItemColor: Color(0xff4b5e7e),
        onTap: _onItemTapped,
        items: _tabMenus
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon,
                      color: (_selectedTab == e.position)
                          ? Color(0xff4b5e7e)
                          : Color(0xffbfc4cc)),
                  title: new Text(e.menuName, style: TextStyle(fontSize: 12)),
                ))
            .toList(),
      ),
    );
  }

  appTitle(context) {
    return Column(
      children: <Widget>[
        Text('BELIEFHACK BRAINARY',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        FutureBuilder<BrainaryUser>(
            future: _authService.getCurrentSignedInUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _currentUser = snapshot.data;
                return Text(snapshot.data.name,
                    style: TextStyle(color: Colors.grey, fontSize: 15));
              }else{
                return Text('Shimmer efect will come here');
              }
            }),
      ],
    );
  }

  // void loadSignedInUser() {
  //   _currentUser = await _authService.getCurrentSignedInUser();
  //   if (_currentUser == null) {
  //     _authService.autoSigninEmailUser(appUid).then((value) {
  //       _currentUser = value;
  //       setState(() {
  //         _currentUserName = value.name;
  //       });
  //     });
  //   }
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }
}

class TabMenu {
  int position;
  String menuName;
  IconData icon;
  TabMenu(this.position, this.menuName, this.icon);
}
