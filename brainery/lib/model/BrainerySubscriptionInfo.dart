class BrainerySubscriptionInfo {
  String planId;
  DateTime startDate;
  String subcriptionId;
  String uid;
  bool isSubscptionValid;

  BrainerySubscriptionInfo(this.planId, this.startDate, this.subcriptionId,
      this.uid, this.isSubscptionValid);

  static BrainerySubscriptionInfo fromDocumentSnapshot(Map data, uid) {
    try {
      DateTime startTime = DateTime.parse(data['startDate']);
      bool isSubscValid = true;
      return BrainerySubscriptionInfo(
          data['planId'], startTime, data['subcriptionId'], uid, isSubscValid);
    } catch (e) {
      print(e);
          return BrainerySubscriptionInfo(
          data['planId'], null, data['subcriptionId'], uid, true);
    }
  }

  toMap() {
    Map resp = {};
    resp['planId'] = planId;
    resp['startDate'] = startDate;
    resp['subcriptionId'] = subcriptionId;
    resp['uid'] = uid;
    resp[isSubscptionValid] = isSubscptionValid;
  }

  static BrainerySubscriptionInfo emptyInfo(uid) {
    return BrainerySubscriptionInfo(null, null, null, uid, false);
  }
}
