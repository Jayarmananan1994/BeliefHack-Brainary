import 'package:brainery/commons/constants.dart';
import 'package:brainery/commons/my_flutter_app_icons.dart';
import 'package:brainery/commons/ui/loading_spinner.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/screens/landing_tab/brainery_drawer.dart';
import 'package:brainery/screens/landing_tab/courses/course.dart';
import 'package:brainery/screens/landing_tab/favorites/favorites.dart';
import 'package:brainery/screens/landing_tab/home/home.dart';
import 'package:brainery/screens/landing_tab/lesson/lesson.dart';
import 'package:brainery/screens/landing_tab/timer/timer.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service_locator.dart';

import 'package:flutter/material.dart';

class LandingTab extends StatefulWidget {
  static const PATH = '/LandingTab';

  @override
  _LandingTabState createState() => _LandingTabState();
}

class _LandingTabState extends State<LandingTab> {
  AuthService _authService = locator<AuthService>();
  int _selectedTab = 0;
  List<Widget> _tabList;

  static List<TabMenu> _tabMenus = [
    TabMenu(0, 'HOME', Icons.home),
    TabMenu(1, 'LESSONS', MyFlutterAppIcons.book_open),
    TabMenu(2, 'COURSES', MyFlutterAppIcons.library_books),
    TabMenu(3, 'PODCAST', MyFlutterAppIcons.podcast),
    TabMenu(4, 'TIMER', MyFlutterAppIcons.clock),
    TabMenu(5, 'FAVORITES', Icons.favorite_border),
  ];

  @override
  void initState() {
    checkConnectionState();
    initializeTabViews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appTitle(context),
        backgroundColor: Theme.of(context).primaryColor,
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
          child: Image.asset(MINI_LOGO_IMAGE_PATH),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _tabList[_selectedTab],
      endDrawer: BraineryDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: _selectedTab,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xffbfc4cc),
        onTap: onItemTapped,
        items: _tabMenus
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon,
                      color: (_selectedTab == e.position)
                          ? Colors.white
                          : Color(0xffbfc4cc)),
                  title: new Text(e.menuName, style: TextStyle(fontSize: 12)),
                ))
            .toList(),
      ),
    );
  }

  Widget appTitle(context) {
    switch (_selectedTab) {
      case 0:
        return titleForHomePage();
      case 1:
        return titleForLessonPage();
      case 2:
        return titleForCoursesPage();
      case 3:
        return titleForPodcastPage();
      case 4:
        return titleForTimerPage();
      case 5:
        return titleForFavoritePage();
      default:
        return titleForHomePage();
    }
  }

  titleForHomePage() {
    return Column(
      children: <Widget>[
        Text('BELIEFHACK BRAINERY', style: TextStyle(color: Colors.white)),
        FutureBuilder<BraineryUser>(
            future: _authService.getCurrentSignedInUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.name,
                    style: TextStyle(color: Colors.grey, fontSize: 15));
              } else {
                return Text('Leon J Morton',
                    style: TextStyle(fontSize: 14, color: Colors.grey));
              }
            }),
      ],
    );
  }

  titleForLessonPage() {
    return Text('LESSONS',
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold));
  }

  titleForCoursesPage() {
    return Text('COURSES', style: TextStyle(color: Colors.white, fontSize: 16));
  }

  titleForPodcastPage() {
    return Text('PODCAST', style: TextStyle(color: Colors.white, fontSize: 16));
  }

  titleForFavoritePage() {
    return Text('FAVORITES',
        style: TextStyle(color: Colors.white, fontSize: 16));
  }

  titleForTimerPage() {
    return Text('INTERVAL TIME',
        style: TextStyle(color: Colors.white, fontSize: 16));
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void viewCourse() {
    setState(() {
      _selectedTab = 2;
    });
  }

  void checkConnectionState() async {}

  void initializeTabViews() {
    _tabList = [
      Home(viewCourseAction: viewCourse),
      Lesson(),
      Course(),
      Center(child: LoadingSpinner(radius: 15.0, dotRadius: 5.0)),
      Timer(),
      Favorites()
    ];
  }
}

class TabMenu {
  int position;
  String menuName;
  IconData icon;
  TabMenu(this.position, this.menuName, this.icon);
}
