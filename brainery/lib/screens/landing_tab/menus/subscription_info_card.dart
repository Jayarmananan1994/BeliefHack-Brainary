import 'package:brainery/model/BrainerySubscriptionInfo.dart';
import 'package:flutter/material.dart';

class SubscriptionInfoCard extends StatelessWidget {
  final BrainerySubscriptionInfo subscriptionInfo;

  const SubscriptionInfoCard({Key key, this.subscriptionInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _titleStyle = TextStyle(color: Color(0xff2c4083), fontSize: 20);
    var _valueStyle = TextStyle(color: Colors.blue);
    print(subscriptionInfo.toMap());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Container(
          margin: EdgeInsets.all(10),
          width: double.infinity,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Plan Name:', style: _titleStyle),
              Text(subscriptionInfo.planName, style: _valueStyle),
              SizedBox(height: 10),
              Text('Starts from:', style: _titleStyle),
              Text(_toReadableDate(subscriptionInfo.startDate),
                  style: _valueStyle),
              SizedBox(height: 10),
              Text('Status:', style: _titleStyle),
              Text(subscriptionInfo.status,
                  style: TextStyle(
                      color: (subscriptionInfo.access)
                          ? Colors.green
                          : Colors.red)),
              SizedBox(height: 10),          
              Text((subscriptionInfo.nextBillingTime !=null)
                  ? 'Next Billing on:'
                  : 'Status updated on:', style: _titleStyle),
              Text(
                  (subscriptionInfo.nextBillingTime !=null)
                      ? _toReadableDate(subscriptionInfo.nextBillingTime)
                      : _toReadableDate(subscriptionInfo.statusUptatedOn),
                  style: _valueStyle)
            ],
          ),
        ),
      ),
    );
  }

  _toReadableDate(DateTime dateTime) {
    return dateTime.day.toString() +
        '-' +
        dateTime.month.toString() +
        '-' +
        dateTime.year.toString();
  }
}
