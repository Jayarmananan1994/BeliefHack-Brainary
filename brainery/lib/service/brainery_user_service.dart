import 'package:brainery/model/BraineryFavorites.dart';
import 'package:brainery/model/BrainerySubscriptionInfo.dart';
import 'package:brainery/model/BraineryUser.dart';
import 'package:brainery/service/auth_service.dart';
import 'package:brainery/service/lesson_and_course_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:cloud_functions/cloud_functions.dart';

class BraineryUserService {
  AuthService authService;
  CloudFunctions cloudFunctions;
  LessonAndCourseService lessonAndCourseService;
  BrainerySubscriptionInfo _subscriptionInfo;

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
    print(currentUser.favoriteLessons.toString());
    _cloudFunctions()
        .getHttpsCallable(functionName: 'updateFavoriteLesson')
        .call({'favoriteLessons': currentUser.favoriteLessons}).then(
            (value) => _authService().setCurrentUser(currentUser));
  }

  updateFavoriteCourse() async {
    BraineryUser currentUser = await getCurrentUser();
    _cloudFunctions()
        .getHttpsCallable(functionName: 'updateFavoriteCourse')
        .call({'favoriteCourse': currentUser.favoriteCourse}).then(
            (value) => _authService().setCurrentUser(currentUser));
  }

  postHelpMessageFromUser(String message) async {
    BraineryUser currentUser = await getCurrentUser();
    var postMessage = {
      "message": message,
      "date": "21-07-2020",
      "emailId": currentUser.emailId
    };
    return _cloudFunctions()
        .getHttpsCallable(functionName: 'postHelpMessage')
        .call(postMessage)
        .then((value) => value.data);
  }

  createSubscriptionForUser(subScriptionId, planId, startDate) {
    var subscriptionMsg = {
      "planId": planId,
      "subscriptionId": subScriptionId,
      "startDate": startDate
    };
    print(subscriptionMsg);
    return _cloudFunctions()
        .getHttpsCallable(functionName: 'createSubscriptionForUser')
        .call(subscriptionMsg)
        .then((value) => value.data);
  }

  Future<BrainerySubscriptionInfo> fetchSubscriptionInfo() async {
    if (_subscriptionInfo == null) {
      var user = await _authService().getCurrentSignedInUser();
      _subscriptionInfo = await _getSubscriptionInfo(user.uid);
    }
    return _subscriptionInfo;
  }

  forceUpdateSubscriptionInfo() async {
    BraineryUser user = await _authService().getCurrentSignedInUser();
    String uid = user.uid;
    _subscriptionInfo = await _getSubscriptionInfo(uid);
    return _subscriptionInfo;
  }

  Future<BrainerySubscriptionInfo> _getSubscriptionInfo(uid) async {
    var param = {"uid": uid};
    BrainerySubscriptionInfo info;
    return _cloudFunctions()
        .getHttpsCallable(functionName: 'getSubscriptionInfo')
        .call(param)
        .then((value) {
      print("Value" + value.data.toString());
      info = BrainerySubscriptionInfo.fromDocumentSnapshot(value.data, uid);
      return info;
    }).catchError((e) {
      print("Error:" + e.toString());
      info = BrainerySubscriptionInfo.emptyInfo(uid);
      return info;
    });

    //     .catchError((error) {
    //   print(error);
    //   info = BrainerySubscriptionInfo.emptyInfo(uid);
    // });
    // info = BrainerySubscriptionInfo.fromDocumentSnapshot(value.data, uid);
    // return info;
  }

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

  CloudFunctions _cloudFunctions() {
    if (cloudFunctions != null) return cloudFunctions;
    cloudFunctions = CloudFunctions.instance;
    return cloudFunctions;
  }
}
