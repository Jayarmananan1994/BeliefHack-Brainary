import 'package:cloud_firestore/cloud_firestore.dart';

class BraineryLesson {
  String title;
  String videoUrl;
  String access;
  String thumbnailImageUrl;
  String length;

  BraineryLesson(this.title, this.videoUrl, this.access, this.thumbnailImageUrl, this.length);
  toMap(){
    Map map = new Map<String, String>();
    map['title'] = title;
    map['videoUrl'] = videoUrl;
    map['access'] = access;
    return map;
  }

   static fromFirestoreDcoument(DocumentSnapshot value) {
    BraineryLesson user = new BraineryLesson(value['title'], value['videoUrl'], value['access'],value['thumbnailImageUrl'], value['length']);
    return user;
  }
}