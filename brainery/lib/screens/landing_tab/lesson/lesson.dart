import 'dart:math';

import 'package:brainery/model/BraineryLesson.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/screens/landing_tab/lesson/lesson_video_player.dart';
import 'package:brainery/screens/landing_tab/lesson/shimmer_layout.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service/brainery_user_service.dart';
import 'package:brainery/service/lesson_and_course_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class Lesson extends StatefulWidget {
  @override
  _LessonState createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  double _height, _width;
  Color _themeColor;
  PageController _pageController;
  double viewPortFraction = 0.9;
  double pageOffset = 0;
  LessonAndCourseService _lessonService = locator<LessonAndCourseService>();
  AuthService _authService = locator<AuthService>();
  BraineryUserService _braineryUserService = locator<BraineryUserService>();
  List<String> _favorites = [];

  @override
  void initState() {
    _fetchUserFavorites();
    super.initState();
    _pageController = PageController(viewportFraction: viewPortFraction)
      ..addListener(() {
        setState(() {
          pageOffset = _pageController.page;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _themeColor = Theme.of(context).primaryColor;
    return Container(
      color: Color(0xfff0f0f6),
      child: FutureBuilder(
        future: getLessonList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<BraineryLesson>> lessonsSnapshot) {
          if (lessonsSnapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                videoSlide(lessonsSnapshot.data),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    child: Text('ALL LESSONS',
                        style: TextStyle(
                            color: _themeColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    color: Colors.white,
                    width: _width),
                videoList(lessonsSnapshot.data),
              ],
            );
          } else if (lessonsSnapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else {
            return ShimmerLayout();
          }
        },
      ),
    );
  }

  Widget videoSlide(List<BraineryLesson> lessons) {
    return Container(
      height: _height * 0.3,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: PageView.builder(
          controller: _pageController,
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            double scale = max(viewPortFraction,
                (1 - (pageOffset - index).abs()) + viewPortFraction);
            return generateVideoPreview(scale, lessons[index]);
          }),
    );
  }

  Future<List<BraineryLesson>> getLessonList() async {
    return _lessonService.getBraineryLessons();
  }

  generateVideoPreview(double scale, BraineryLesson lesson) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius: 2,
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
                child: Image.network(lesson.thumbnailImageUrl,
                    width: _width, fit: BoxFit.fitHeight)),
          ),
          Center(
            child: IconButton(
                icon: Icon(Icons.play_circle_outline, size: 50),
                onPressed: () {},
                color: Colors.white),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lesson.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text(lesson.length, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          Positioned(
            right: 30,
            child: IconButton(
                icon: Icon(_favIcon(lesson), color: Colors.white, size: 40),
                onPressed: () => handleFav(lesson)),
          )
        ],
      ),
    );
  }

  videoList(List<BraineryLesson> lessons) {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: lessons.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(thickness: 1, indent: 15, endIndent: 15),
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(lessons[index].thumbnailImageUrl),
                subtitle: Text(lessons[index].length,
                    style: TextStyle(color: Colors.black)),
                title: Text(lessons[index].title,
                    style: TextStyle(
                        color: _themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                trailing: IconButton(
                  icon: Icon(_favIcon(lessons[index]),
                      color: _themeColor, size: 30),
                  onPressed: () => handleFav(lessons[index]),
                ),
                onTap: () async {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        bool isFav = _favorites.contains(lessons[index].title);
                        return SafeArea(
                            child: LessonVideoPlayer(lessons[index],handleFav,isFavorite: isFav));
                      },
                      isDismissible: false,
                      isScrollControlled: true);
                },
              );
            }),
      ),
    );
  }

  IconData _favIcon(lesson) {
    if (_favorites.contains(lesson.title)) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }

  void _fetchUserFavorites() async {
    BraineryUser user = await _authService.getCurrentSignedInUser();
    setState(() {
      _favorites = user.favoriteLessons;
    });
  }

  handleFav(BraineryLesson lesson) {
    if (_favorites.contains(lesson.title)) {
      removeFromFavorite(lesson.title);
    } else {
      addToFavorite(lesson.title);
    }
  }

  addToFavorite(String lesson){
     setState(() {
      _favorites.add(lesson);
    });
    _braineryUserService.updateFavoriteLesson();
   
  }

  removeFromFavorite(String lesson) {
    setState(() {
      _favorites.remove(lesson);
    });
    _braineryUserService.updateFavoriteLesson();
    
  }
}
