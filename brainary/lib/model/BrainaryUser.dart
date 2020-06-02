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

}