import 'package:brainery/model/BraineryFavorites.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service/lesson_and_course_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BraineryUserService {
  AuthService authService;
  Firestore firestore;
  LessonAndCourseService lessonAndCourseService;

  Future<BraineryFavorites> getUserFavotires() async {
    BraineryUser currentUser = await getCurrentUser();

    List<LessonFav> favLessonName = (currentUser.favoriteLessons.length == 0)
        ? []
        : await generateLessonFav(currentUser.favoriteLessons);
    List<CourseFav> favCourseName = (currentUser.favoriteCourse.length == 0)
        ? []
        : await generateCourseFav(currentUser.favoriteCourse);
    return BraineryFavorites(favLessonName, favCourseName);
  }

  Future<List<LessonFav>> generateLessonFav(List<String> favLessons) async {
    var lessons = await _lessonAndCourseService().getBraineryLessons();
    return lessons
        .where((lesson) => favLessons.contains(lesson.title))
        .map((e) => LessonFav(e.title, e.thumbnailImageUrl, e.length))
        .toList();
  }

  Future<List<CourseFav>> generateCourseFav(List<String> favCourses) async {
    var lessons = await _lessonAndCourseService().getBraineryCourseList();
    return lessons
        .where((lesson) => favCourses.contains(lesson.courseName))
        .map((e) => CourseFav(e.courseName, e.previewImage))
        .toList();
  }

  updateFavoriteLesson() async {
    BraineryUser currentUser = await getCurrentUser();
    _firestore()
        .collection('users')
        .document(currentUser.uid)
        .updateData({'favoriteLessons': currentUser.favoriteLessons}).then(
            (value) => _authService().setCurrentUser(currentUser));
  }


  updateFavoriteCourse() async {
    BraineryUser currentUser = await getCurrentUser();
    _firestore()
        .collection('users')
        .document(currentUser.uid)
        .updateData({'favoriteCourse': currentUser.favoriteCourse}).then(
            (value) => _authService().setCurrentUser(currentUser));
  }

  // removeFavoriteCourse(String course) async {
  //   BraineryUser currentUser = await getCurrentUser();
  //   currentUser.favoriteCourse.remove(course);
  //   _firestore()
  //       .collection('users')
  //       .document(currentUser.uid)
  //       .updateData({'favoriteCourse': currentUser.favoriteCourse}).then(
  //           (value) => _authService().setCurrentUser(currentUser));
  // }

  Future<BraineryUser> getCurrentUser() {
    return _authService().getCurrentSignedInUser();
  }

  AuthService _authService() {
    if (authService != null) return authService;
    authService = locator<AuthService>();
    return authService;
  }

  LessonAndCourseService _lessonAndCourseService() {
    if (lessonAndCourseService != null) return lessonAndCourseService;
    lessonAndCourseService = locator<LessonAndCourseService>();
    return lessonAndCourseService;
  }

  Firestore _firestore() {
    if (firestore != null) return firestore;
    firestore = Firestore.instance;
    return firestore;
  }
}
