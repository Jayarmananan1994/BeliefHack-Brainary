import 'dart:math';

import 'package:brainery/model/BraineryCourse.dart';
import 'package:brainery/model/BrainerySubscriptionInfo.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/screens/course_list/course_list.dart';
import 'package:brainery/screens/landing_tab/lesson/shimmer_layout.dart';
import 'package:brainery/screens/payment/payment.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service/brainery_user_service.dart';
import 'package:brainery/service/lesson_and_course_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Course extends StatefulWidget {
  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  double _height, _width;
  Color _themeColor;
  PageController _pageController;
  double viewPortFraction = 0.9;
  double pageOffset = 0;
  LessonAndCourseService _lessonService = locator<LessonAndCourseService>();
  AuthService _authService = locator<AuthService>();
  BraineryUserService _braineryUserService = locator<BraineryUserService>();
  List<String> _favCourses = [];
  BrainerySubscriptionInfo _subscriptionInfo;

  @override
  void initState() {
    fetchSubscriptionInfo();
    fetchFavCourses();
    _pageController = PageController(viewportFraction: viewPortFraction)
      ..addListener(() {
        setState(() {
          pageOffset = _pageController.page;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _themeColor = Theme.of(context).primaryColor;
    //print(_subscriptionInfo);
    //print(">>>>>>>>>>Subscription info:"+ _subscriptionInfo?.access.toString());
    return Container(
      child: FutureBuilder<Object>(
          future: _lessonService.getBraineryCourseList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var courses = snapshot.data;
              return Column(
                children: <Widget>[
                 ( _subscriptionInfo!=null && _subscriptionInfo.access) ? Container() : _disclaimer(),
                  coursePreviewSlide(courses),
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                      child: Text('ALL COURSES',
                          style: TextStyle(
                              color: _themeColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      color: Colors.white,
                      width: _width),
                  courseList(courses)
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching data'));
            } else {
              return ShimmerLayout();
            }
          }),
    );
  }

  Widget _disclaimer() {
    return Text('The course are accesible only for subscribers*',
        style: TextStyle(color: Colors.red));
  }

  Widget coursePreviewSlide(courses) {
    return Container(
      height: _height * 0.3,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: PageView.builder(
          controller: _pageController,
          itemCount: courses.length,
          itemBuilder: (context, index) {
            double scale = max(viewPortFraction,
                (1 - (pageOffset - index).abs()) + viewPortFraction);
            return generateVideoPreview(scale, courses[index]);
          }),
    );
  }

  Widget generateVideoPreview(double scale, BraineryCourse course) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 2
                //offset: Offset(-1, 0)
                )
          ]),
      margin: EdgeInsets.only(
        right: 35,
        top: 50 - scale * 25,
        bottom: 50 - scale * 25,
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: (course.previewImage!=null) ? Image.network( course.previewImage,
                    width: _width, fit: BoxFit.fitHeight) :  Container(width: _width)),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            child: Text(course.courseName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          Positioned(
            right: 30,
            child: IconButton(
                icon: Icon(_favIcon(course.courseName),
                    color: Colors.white, size: 40),
                onPressed: () => handleFav(course)),
          )
        ],
      ),
    );
  }

  courseList(List<BraineryCourse> courses) {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: courses.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(thickness: 1, indent: 15, endIndent: 15),
            itemBuilder: (context, index) {
              return ListTile(
                leading: _imageBox(courses[index]
                    .previewImage),
                title: Text(courses[index].courseName,
                    style: TextStyle(
                        color: _themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                trailing: IconButton(
                    icon: Icon(_favIcon(courses[index].courseName),
                        color: _themeColor, size: 30),
                    onPressed: () => handleFav(courses[index])),
                onTap: () => ( _subscriptionInfo!=null && _subscriptionInfo.access) ? gotoCoursePage(courses[index]) : gotoPayment(),
              );
            }),
      ),
    );
  }

  _imageBox(url) {
    return Container(
      width: 100.0,
      child: Stack(
        children: <Widget>[
          FadeInImage.memoryNetwork(
              placeholder: kTransparentImage, image: url, width: 100.0),
          ( _subscriptionInfo !=null && _subscriptionInfo.access)
              ? Container()
              : Align(
                  child: Icon(Icons.lock, size: 35, color: Colors.white),
                  alignment: Alignment.center)
        ],
      ),
    );
  }

  IconData _favIcon(courseName) {
    if (_favCourses.contains(courseName)) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }

  void fetchFavCourses() async {
    BraineryUser currentUser = await _authService.getCurrentSignedInUser();
    print(currentUser.favoriteCourse);
    setState(() {
      _favCourses = currentUser.favoriteCourse;
    });
  }

  handleFav(BraineryCourse course) {
    if (_favCourses.contains(course.courseName)) {
      removeFromFavorite(course.courseName);
    } else {
      addToFavorite(course.courseName);
    }
  }

  addToFavorite(String course) {
    setState(() {
      _favCourses.add(course);
    });
    _braineryUserService.updateFavoriteCourse();
  }

  removeFromFavorite(String course) {
    setState(() {
      _favCourses.remove(course);
    });
    _braineryUserService.updateFavoriteCourse();
  }

  gotoPayment() {
    Navigator.of(context).pushNamed(Payment.PATH);
  }

  gotoCoursePage(course){
     Navigator.of(context).pushNamed(CourseList.PATH,arguments: course );
  }

  void fetchSubscriptionInfo() async {
    var value = await _braineryUserService.fetchSubscriptionInfo();
    setState(() {
      _subscriptionInfo = value;
    });
  }
}
