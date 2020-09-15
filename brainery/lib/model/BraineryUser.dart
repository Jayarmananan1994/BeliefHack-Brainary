
class BraineryUser {
  String uid;
  String name;
  String emailId;
  List<String> favoriteCourse;
  List<String> favoriteLessons;
  String profileImage;

  BraineryUser(this.uid, this.name, this.emailId, this.favoriteLessons,
      this.favoriteCourse, this.profileImage);

  toMap() {
    Map map = new Map<String, dynamic>();
    map['uid'] = uid;
    map['name'] = name;
    map['emailId'] = emailId;
    map['favoriteCourse'] = favoriteCourse;
    map['favoriteLessons'] = favoriteLessons;
    map['profileImage'] = profileImage;
    return map;
  }

  static fromMap(Map value) {
    List<String> lessons = List<String>.from(value['favoriteLessons']);
    List<String> courses = List<String>.from(value['favoriteCourse']);
    BraineryUser user = BraineryUser(
        value['uid'], value['name'], value['emailId'], lessons, courses, value['profileImage']);
    return user;
  }

  dynamicToString() {}
}
