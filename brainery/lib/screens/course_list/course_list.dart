import 'package:brainery/model/BraineryCourse.dart';
import 'package:brainery/model/BraineryLesson.dart';
import 'package:brainery/service/lesson_and_course_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CourseList extends StatefulWidget {
  static const String PATH = '/course-list';
  final BraineryCourse braineryCourse;
  CourseList({@required this.braineryCourse});
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  double _width, _height;
  Color _themeColor;
  LessonAndCourseService _courseService = locator<LessonAndCourseService>();

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    _themeColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: Container(
        height: _height,
        width: _width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_imagecontainer(), _title(), _courseContentList()]),
      ),
    );
  }

  Container _title() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Text(widget.braineryCourse.courseName,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: _themeColor)));
  }

  _imagecontainer() {
    return Container(
      height: _height * 0.35,
      child: Stack(
        children: <Widget>[
          FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: widget.braineryCourse.previewImage,
              fit: BoxFit.fitHeight,
              height: _height * 0.35,
              width: _width),
          Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop()))
        ],
      ),
    );
  }

  _courseContentList() {
    return FutureBuilder<List<BraineryLesson>>(
        future: _courseService.getCourseContent(widget.braineryCourse.courseId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(child: _courseContentListView(snapshot.data));
          } else if (snapshot.hasError) {
            return Text('Error fetching the data. Please try again later.');
          } else {
            return Text('Fetching the Course content');
          }
        });
  }

  _courseContentListView(List<BraineryLesson> lessons) {
    
    return Container(
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.separated(
            itemCount: lessons.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(thickness: 1, indent: 15, endIndent: 15),
            itemBuilder: (context, index) {
              var lesson = lessons[index];
              return ListTile(
                leading: _imageBox(lesson.thumbnailImageUrl),
                title: Text(lesson.title, style: TextStyle(color: _themeColor, fontWeight: FontWeight.w600)),
                subtitle: Text(lesson.length),
              );
            }),
      ),
    );
  }

  _imageBox(url) {
    return Container(
      width: 100.0,
      child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage, image: url, width: 100.0),
    );
  }

  // courseList() {}
}
