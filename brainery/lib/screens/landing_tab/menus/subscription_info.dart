import 'package:brainery/commons/ui/brainery_button.dart';
import 'package:brainery/model/BrainerySubscriptionInfo.dart';
import 'package:brainery/screens/landing_tab/menus/subscription_info_card.dart';
import 'package:brainery/service/brainery_user_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class SubscriptionInfo extends StatelessWidget {
  static const String PATH = '/subscription-info';

  final BraineryUserService _braineryUserService =
      locator<BraineryUserService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<BrainerySubscriptionInfo>(
          future: _braineryUserService.fetchSubscriptionInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              if (data != null && data.planId != null) {
                return _subscriptionInfoPage(data, context);
              } else {
                return _noSubscriptionAvailable();
              }
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }

  _subscriptionInfoPage(BrainerySubscriptionInfo data, context) {
    return Container(
      color: Color(0xff2c4083),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop()),
                Container(
                    child: Center(
                        child: Text('Subscription ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)))),
                Container(
                  width: 30,
                )
              ]),
          SizedBox(height: 20),
          Text(data.access ? 'Current plan' : 'Previously purchased plan',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 10),
          SubscriptionInfoCard(subscriptionInfo: data),
          //(data.status!='CANCELLED') ?  _cancelButton() : _subscribeButton()
        ],
      ),
    );
  }

   _cancelButton(){
    return BraineryButton(buttonAction: (){}, buttonText: 'Cancel Subscription');
  }

  _subscribeButton() {
    return BraineryButton(buttonAction: (){}, buttonText: 'Subscribe');
  }


  Widget _noSubscriptionAvailable() {
    return Center(
      child: Text('No subscription avaialble'),
    );
  }
}
