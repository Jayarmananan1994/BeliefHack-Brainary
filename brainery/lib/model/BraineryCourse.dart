
class BraineryCourse {
  String courseName;
  String previewImage;
  String courseId;

  BraineryCourse(this.courseName, this.previewImage, this.courseId);

  toMap() {
    Map map = new Map<String, String>();
    map['courseName'] = courseName;
    map['previewImage'] = previewImage;
    map['courseId'] = courseId;
    return map;
  }

  // static fromFirestoreDcoument(DocumentSnapshot value) {
  //   BraineryCourse user = BraineryCourse(
  //       value['courseName'], value['previewImage'], value['courseId']);
  //   return user;
  // }
}
