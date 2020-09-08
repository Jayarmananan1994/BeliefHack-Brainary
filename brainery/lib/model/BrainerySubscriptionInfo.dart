class BrainerySubscriptionInfo {
  String subscriptionId;
  String status;
  DateTime startDate;
  String planId;
  String planName;
  String planDescription;
  DateTime statusUptatedOn;
  DateTime nextBillingTime;
  String uid;
  bool access;

  BrainerySubscriptionInfo(
      this.subscriptionId,
      this.status,
      this.startDate,
      this.planId,
      this.planName,
      this.planDescription,
      this.statusUptatedOn,
      this.nextBillingTime,
      this.uid,
      this.access);

  static BrainerySubscriptionInfo fromDocumentSnapshot(Map data, uid) {
    try {
      String subsId = data['subscriptionId'];
      String status = data['status'];
      DateTime startTime = (data['createdTime'] != null)
          ? DateTime.parse(data['createdTime'])
          : null;
      String planId = data['planId'];
      String planName = data['planName'];
      String planDescription = data['planDescription'];
      DateTime statusUptatedOn = (data['statusUpdateOn'] != null)
          ? DateTime.parse(data['statusUpdateOn'])
          : null;
      DateTime nextBillingTime =
          (data['nextBillingTime'] != null) ? DateTime.parse(data['nextBillingTime']) : null;
      bool isSubscValid = data['access'];
      return BrainerySubscriptionInfo(
          subsId,
          status,
          startTime,
          planId,
          planName,
          planDescription,
          statusUptatedOn,
          nextBillingTime,
          uid,
          isSubscValid);
    } catch (e) {
      print(e);
      throw e;
      // return BrainerySubscriptionInfo(
      // data['planId'], null, data['subcriptionId'], uid, false);
    }
  }

  toMap() {
    Map resp = {};
    resp['subcriptionId'] = subscriptionId;
    resp['status'] = status;
    resp['startDate'] = startDate;
    resp['planId'] = planId;
    resp['statusUptatedOn'] = statusUptatedOn;
    resp['nextBillingTime'] = nextBillingTime;
    resp['uid'] = uid;
    resp['access'] = access;
    return resp;
  }

  static BrainerySubscriptionInfo emptyInfo(uid) {
    return BrainerySubscriptionInfo(
        null, null, null, null, null, null, null, null, uid, false);
  }
}
