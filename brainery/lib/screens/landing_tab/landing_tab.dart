import 'package:brainery/commons/constants.dart';
import 'package:brainery/commons/my_flutter_app_icons.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/screens/landing_tab/brainery_drawer.dart';
import 'package:brainery/screens/landing_tab/home/home.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class LandingTab extends StatefulWidget {
  static const PATH = '/LandingTab';

  @override
  _LandingTabState createState() => _LandingTabState();
}

class _LandingTabState extends State<LandingTab> {
  BraineryUser _currentUser;
  AuthService _authService = locator<AuthService>();
  int _selectedTab = 0;
  static List<Widget> _tabList = [
     Home(),
    //Center(child: Text('Home Tab comes here')),
    Center(child: Text('Lesson Tab comes here')),
    Center(child: Text('Course Tab comes here')),
    Center(child: Text('Timer Tab comes here')),
    Center(child: Text('Favoite Tab comes here'))
  ];

  static List<TabMenu> _tabMenus = [
    TabMenu(0, 'HOME', Icons.home),
    TabMenu(1, 'LESSONS', MyFlutterAppIcons.book_open),
    TabMenu(2, 'COURSES', MyFlutterAppIcons.library_books),
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
      endDrawer: BraineryDrawer(),
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
        Text('BELIEFHACK BRAINERY',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        FutureBuilder<BraineryUser>(
            future: _authService.getCurrentSignedInUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _currentUser = snapshot.data;
                return Text(snapshot.data.name,
                    style: TextStyle(color: Colors.grey, fontSize: 15));
              }else{
                return Text('Leon J Morton', style: TextStyle(fontSize: 14, color: Colors.grey));
              }
            }),
      ],
    );
  }

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
