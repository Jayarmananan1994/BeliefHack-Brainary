import 'package:brainery/model/BraineryCourse.dart';
import 'package:brainery/model/BraineryLesson.dart';
import 'package:cloud_functions/cloud_functions.dart';

class LessonAndCourseService {
  List<BraineryLesson> _braineryLessons;
  List<BraineryCourse> _braineryCourse;

  Future<List<BraineryLesson>> getBraineryLessons() async {
    if (_braineryLessons == null) {
      CloudFunctions cloudFunctions = CloudFunctions.instance;
      var snapshot = await cloudFunctions
          .getHttpsCallable(functionName: 'getLessons')
          .call();
      List documents = snapshot.data;
      _braineryLessons = documents
          .map((e) => BraineryLesson(e['title'], e['videoUrl'], e['access'],
              e['thumbnailImageUrl'], e['length'])).toList();
      return _braineryLessons;
    } else {
      return _braineryLessons;
    }
  }

  Future<List<BraineryCourse>> getBraineryCourseList() async {
    if (_braineryCourse == null) {
      // var snapshot = await firestore
      //     .collection('course_list')
      //     .orderBy('courseName')
      //     .getDocuments();
      // var documents = snapshot.documents;
      CloudFunctions cloudFunctions = CloudFunctions.instance;
      var snapshot = await cloudFunctions
          .getHttpsCallable(functionName: 'getCourseList')
          .call();
      print(snapshot.data);
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
}
