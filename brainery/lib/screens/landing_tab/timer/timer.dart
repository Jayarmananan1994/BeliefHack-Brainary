import 'package:brainery/commons/ui/loading_spinner.dart';
import 'package:brainery/model/BraineryLesson.dart';
import 'package:brainery/service/lesson_and_course_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {

  LessonAndCourseService _lessonAndCourseService =
      locator<LessonAndCourseService>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(onPressed: () { 
            showLoadingDialog();
         },
        child: Text('Timer')),
        
      ),
    );
  }

  Future<List<BraineryLesson>> getLessonList() {
    return _lessonAndCourseService.getBraineryLessons();
  }
          
  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 100,
            child: Center(
                child: Row(
              children: <Widget>[
                LoadingSpinner(radius: 15.0, dotRadius: 5.0),
                Text('Please hold on.'),
              ],
            )),
          ),
        );
      },
    );
  }
}
