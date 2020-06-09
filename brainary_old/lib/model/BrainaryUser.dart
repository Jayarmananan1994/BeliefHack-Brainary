import 'package:cloud_firestore/cloud_firestore.dart';

class BrainaryUser {
  String uid;
  String name;
  String emailId;

  BrainaryUser(this.uid, this.name, this.emailId);

  toMap(){
    Map map = new Map<String, String>();
    map['uid'] = uid;
    map['name'] = name;
    map['emailId'] = emailId;
    return map;
  }

  static fromFirestoreDcoument(DocumentSnapshot value) {
    BrainaryUser user = new BrainaryUser(value['uid'], value['name'], value['emailId']);
    return user;
  }

}