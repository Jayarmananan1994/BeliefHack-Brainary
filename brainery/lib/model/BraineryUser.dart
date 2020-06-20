import 'package:cloud_firestore/cloud_firestore.dart';

class BraineryUser {
  String uid;
  String name;
  String emailId;
  List<String> favoriteCourse;
  List<String> favoriteLessons;

  BraineryUser(this.uid, this.name, this.emailId, this.favoriteLessons,
      this.favoriteCourse);

  toMap() {
    Map map = new Map<String, String>();
    map['uid'] = uid;
    map['name'] = name;
    map['emailId'] = emailId;
    return map;
  }

  static fromFirestoreDcoument(DocumentSnapshot value) {
    List<String> lessons = List<String>.from(value['favoriteLessons']);
    List<String> courses = List<String>.from(value['favoriteCourse']);
    BraineryUser user = BraineryUser(
        value['uid'], value['name'], value['emailId'], lessons, courses);
    return user;
  }

  dynamicToString() {}
}
