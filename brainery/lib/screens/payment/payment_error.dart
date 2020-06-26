import 'package:brainery/screens/landing_tab/landing_tab.dart';
import 'package:brainery/screens/payment/payment.dart';
import 'package:flutter/material.dart';

class PaymentError extends StatelessWidget {
  static const String PATH = '/payment-error';
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    Color _themeColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(title: Text('PAYMENT FAILED')),
      body: Container(
        width: _width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.close, color: Colors.red, size: 70),
            SizedBox(height: 10),
            Text('Opps...!',
                style: TextStyle(color: Colors.green, fontSize: 20)),
            SizedBox(height: 10),
            Text('The payment failed for some reason.',
                style: TextStyle(fontSize: 16)),
            Text('Please click retry to try again.',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),
            RaisedButton(
                shape: StadiumBorder(),
                onPressed: () => Navigator.of(context).pushNamed(LandingTab.PATH),
                child: Text('Home', style: TextStyle(color: Colors.white)),
                color: _themeColor),
            RaisedButton(
                shape: StadiumBorder(),
                onPressed: () => Navigator.of(context).pushNamed(Payment.PATH),
                child: Text('Retry', style: TextStyle(color: Colors.white)),
                color: _themeColor)
          ],
        )
      ),
    );
  }
}
