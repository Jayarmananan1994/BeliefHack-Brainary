import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:flutter/material.dart';
import 'package:brainery/service/brainery_user_service.dart';
import 'package:brainery/service_locator.dart';

class PaymentSucess extends StatelessWidget {
  static const String PATH = '/payment-sucess';
    final BraineryUserService _braineryUserService =
      locator<BraineryUserService>();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    Color _themeColor = Theme.of(context).primaryColor;
    return Container(
        width: _width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle, color: Colors.green, size: 70),
            SizedBox(height: 10),
            Text('PAYMENT SUCCESS',
                style: TextStyle(color: Colors.green, fontSize: 20)),
            SizedBox(height: 10),
            Text('Thanks for purchasing the subscription',
                style: TextStyle(fontSize: 16)),
            Text('Enjoy the courses and lessons',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            RaisedButton(
                shape: StadiumBorder(),
                onPressed: (){
                   _braineryUserService.resetSubscriptionInfo();
                  Navigator.of(context).pushNamed(LandingTab.PATH);
                },
                child: Text('Home', style: TextStyle(color: Colors.white)),
                color: _themeColor),
            // RaisedButton(
            //     shape: StadiumBorder(),
            //     onPressed: () => Navigator.of(context).pop(),
            //     child: Text('Home', style: TextStyle(color: _themeColor)),
            //     color: Colors.white)
          ],
        ),
    );
  }
}
