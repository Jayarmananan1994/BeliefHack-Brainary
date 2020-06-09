import 'package:cloud_firestore/cloud_firestore.dart';

class BraineryUser {
  String uid;
  String name;
  String emailId;

  BraineryUser(this.uid, this.name, this.emailId);

  toMap(){
    Map map = new Map<String, String>();
    map['uid'] = uid;
    map['name'] = name;
    map['emailId'] = emailId;
    return map;
  }

  static fromFirestoreDcoument(DocumentSnapshot value) {
    BraineryUser user = new BraineryUser(value['uid'], value['name'], value['emailId']);
    return user;
  }

}