import 'package:brainery/model/BraineryCourse.dart';
import 'package:brainery/model/BraineryLesson.dart';
import 'package:cloud_functions/cloud_functions.dart';

class LessonAndCourseService {
  List<BraineryLesson> _braineryLessons;
  List<BraineryCourse> _braineryCourse;
  Map<String, List<BraineryLesson>> _courseContentMap = {};

  Future<List<BraineryLesson>> getBraineryLessons() async {
    if (_braineryLessons == null) {
      CloudFunctions cloudFunctions = CloudFunctions.instance;
      var snapshot = await cloudFunctions
          .getHttpsCallable(functionName: 'getLessons')
          .call();
      List documents = snapshot.data;
      _braineryLessons = documents
          .map((e) => BraineryLesson(e['title'], e['videoUrl'], e['access'],
              e['thumbnailImageUrl'], e['length']))
          .toList();
      return _braineryLessons;
    } else {
      return _braineryLessons;
    }
  }

  Future<List<BraineryCourse>> getBraineryCourseList() async {
    if (_braineryCourse == null) {
      CloudFunctions cloudFunctions = CloudFunctions.instance;
      var snapshot = await cloudFunctions
          .getHttpsCallable(functionName: 'getCourseList')
          .call();
      List documents = snapshot.data;
      _braineryCourse = documents
          .map((e) =>
              BraineryCourse(e['courseName'], e['previewImage'], e['courseId']))
          .toList();
      return _braineryCourse;
    } else {
      return _braineryCourse;
    }
  }

  Future<List<BraineryLesson>> getCourseContent(courseId) async {
    if (_courseContentMap[courseId] == null) {
      CloudFunctions cloudFunctions = CloudFunctions.instance;
      var param = {"courseName": 'course1'};
      var snapshot = await cloudFunctions
          .getHttpsCallable(functionName: 'getCourseContent')
          .call(param);
      List documents = snapshot.data;
      _courseContentMap[courseId] = documents
          .map((e) => BraineryLesson(e['title'], e['videoUrl'], e['access'],
              e['previewImage'], e['length']))
          .toList();
    }
    return _courseContentMap[courseId];
  }
}
