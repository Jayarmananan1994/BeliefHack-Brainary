import 'dart:math';

import 'package:brainery/model/BraineryCourse.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/screens/landing_tab/lesson/shimmer_layout.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service/brainery_user_service.dart';
import 'package:brainery/service/lesson_and_course_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
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
    return Container(
      child: FutureBuilder<Object>(
          future: _lessonService.getBraineryCourseList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var courses = snapshot.data;
              return Column(
                children: <Widget>[
                  _disclaimer(),
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
          borderRadius: BorderRadius.circular(25),
          color: Colors.black,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 2
                //offset: Offset(-1, 0)
                )
          ]),
      margin: EdgeInsets.only(
        right: 15,
        top: 50 - scale * 25,
        bottom: 50 - scale * 25,
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(course.previewImage,
                    width: _width, fit: BoxFit.fitHeight)),
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
                icon:
                    Icon(_favIcon(course.courseName), color: Colors.white, size: 40),
                onPressed:  () => handleFav(course)),
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
                leading: Image.network(courses[index].previewImage),
                title: Text(courses[index].courseName,
                    style: TextStyle(
                        color: _themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                trailing:
                    Icon(_favIcon(courses[index].courseName), color: _themeColor, size: 30),
                onTap: () => handleFav(courses[index]),
              );
            }),
      ),
    );
  }

  IconData _favIcon(courseName) {
      if(_favCourses.contains(courseName)){
        return Icons.favorite;
      }else{
        return Icons.favorite_border;
      } 
  }

  void fetchFavCourses() async{
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
}
