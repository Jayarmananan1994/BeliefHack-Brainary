import 'dart:convert';

import 'package:brainery/commons/constants.dart';
import 'package:brainery/commons/ui/loading_spinner.dart';
import 'package:brainery/model/SquarePaymentResponse.dart';
import 'package:brainery/screens/payment/payment_error.dart';
import 'package:brainery/screens/payment/payment_success.dart';
import 'package:brainery/screens/payment/paypal_subscription.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart' as httpModel;

class Payment extends StatelessWidget {
  static const String PATH = '/payment';
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    //double _height = MediaQuery.of(context).size.height;
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Container(
        //height: _height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child: Center(
              child:
                  Text('Content related to the subscription\n\twill come here'),
            )),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: _buySubscriptionButton(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buySubscriptionButton(context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
        child: RaisedButton(
            padding: EdgeInsets.all(0),
            textColor: Colors.white,
            onPressed: () => Navigator.of(context).pushNamed(
                PaypalSubscription.PATH,
                arguments: _paymentOnFinish), //_handlePayment(context),
            child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff247ae7), Color(0xff089ee2)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('BUY SUBSCRIPTION \$ 50'),
                    Icon(Icons.arrow_forward)
                  ],
                ))),
      ),
    );
  }

  _handlePayment(context) async {
    await InAppPayments.setSquareApplicationId(SQUARE_PAY_APPLICATION_ID);
    InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: (httpModel.CardDetails details) {
      print(details.nonce);
      InAppPayments.completeCardEntry(onCardEntryComplete: () async {
        print('Payment done');
        showLoadingDialog(context);
        http.Response response = await http
            .post(SQUARE_PAY_SERVICE_URL, body: {'nonce': details.nonce});
        Map jsonResponse = jsonDecode(response.body);
        var squarePaymentResponse =
            SquarePaymentResponse.fromJson(jsonResponse);
        Navigator.of(context).pop();
        if (squarePaymentResponse.payment.status == 'COMPLETED') {
          Navigator.of(context).pushNamed(PaymentSucess.PATH);
        } else {
          Navigator.of(context).pushNamed(PaymentError.PATH);
        }
        // print(response.body.toString());
      });
    }, onCardEntryCancel: () {
      print("canceled");
    });
  }

  showLoadingDialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 100,
            child: Center(
                child: Row(
              children: <Widget>[
                LoadingSpinner(radius: 15.0, dotRadius: 5.0),
                Flexible(
                    child: Text(
                        "Payment in progress.Please don't press back button.")),
              ],
            )),
          ),
        );
      },
    );
  }

  _paymentOnFinish(paymentResponse) {
    print('Payment done>>>>>' + paymentResponse.toString());
    if(paymentResponse["subscription_id"]!=null){
       Navigator.of(_context).pushNamed(PaymentSucess.PATH);
    }else{
       Navigator.of(_context).pushNamed(PaymentError.PATH);
    }
  }
}
