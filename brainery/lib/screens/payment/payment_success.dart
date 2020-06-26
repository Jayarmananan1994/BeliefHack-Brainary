import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:flutter/material.dart';

class PaymentSucess extends StatelessWidget {
  static const String PATH = '/payment-sucess';
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    Color _themeColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Done'),
      ),
      body: Container(
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
                onPressed: () => Navigator.of(context).pushNamed(LandingTab.PATH),
                child: Text('Home', style: TextStyle(color: Colors.white)),
                color: _themeColor)
          ],
        ),
      ),
    );
  }
}
