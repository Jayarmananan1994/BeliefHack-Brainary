import 'package:brainery/commons/ui/brainery_alert_dialog.dart';
import 'package:brainery/commons/ui/brainery_button.dart';
import 'package:brainery/commons/ui/loading_spinner.dart';
import 'package:brainery/model/BrainerySubscriptionInfo.dart';
import 'package:brainery/screens/landing_tab/menus/privacy.dart';
import 'package:brainery/screens/landing_tab/menus/subscription_info_card.dart';
import 'package:brainery/screens/landing_tab/menus/terms.dart';
import 'package:brainery/screens/payment/payment_error.dart';
import 'package:brainery/screens/payment/payment_success.dart';
import 'package:brainery/screens/payment/paypal_subscription.dart';
import 'package:brainery/service/PaypalService.dart';
import 'package:brainery/service/brainery_user_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Payment extends StatefulWidget {
  static const String PATH = '/payment';
  static const String MONTH_PLAN = 'P-1P139113Y18878525L4SDYAY';
  static const String YEAR_PLAN = 'P-1TG08431G6640442UL4SY4QA';

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  double _width;
  Scenario scenario = Scenario.SUBSCRIPTION_PAGE;
  bool _isLoading = false;
  bool showSubscriptionPage = false;

  final BraineryUserService _braineryUserService =
      locator<BraineryUserService>();

  final PaypalServices _paypalServices = locator<PaypalServices>();

  @override
  Widget build(BuildContext context) {
    print('Building widget again');
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _getPageContent(),
    );
  }

  _getPageContent() {
    if (scenario == Scenario.PAYMENT_SUCCESS) {
      return PaymentSucess();
    } else if (scenario == Scenario.PAYMENT_FAILURE) {
      return PaymentError();
    } else {
      return FutureBuilder<BrainerySubscriptionInfo>(
          future: _braineryUserService.fetchSubscriptionInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              if (!data.access || showSubscriptionPage) {
                return _subscriptionPage();
              } else {
                return _subscriptionInfoPage(data);
              }
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          });
      //_braineryUserService.fetchSubscriptionInfo();
      //return _subscriptionPage();
    }
  }

  _subscriptionPage() {
    return Container(
      color: Color(0xff2c4083),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: 20),
          Row(children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.of(context).pop())
          ]),
          SizedBox(height: 20),
          _title(),
          _features(),
          _buySubscriptionButton(
              context, 'SUBSCRIPTION for \$ 10/Month', Payment.MONTH_PLAN),
          _buySubscriptionButton(
              context, 'SUBSCRIPTION for \$ 100/Year', Payment.YEAR_PLAN),
          _termsAndPrivacy(),
          _disclaimerMessage(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  _subscriptionInfoPage(BrainerySubscriptionInfo data) {
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
                Container(width: 30)
              ]),
          SizedBox(height: 20),
          Text(data.access ? 'Current plan' : 'Previously purchased plan',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 10),
          SubscriptionInfoCard(subscriptionInfo: data),
          (data.status != 'CANCELLED')
              ? _cancelButton(data.subscriptionId)
              : _subscribeButton()
        ],
      ),
    );
  }

  _cancelButton(subscriptionId) {
    return BraineryButton(
        buttonAction: () => _cancelSubscription(subscriptionId),
        buttonText: (!_isLoading) ? 'Cancel Subscription' : 'Cancelling..');
  }

  _subscribeButton() {
    return BraineryButton(
        buttonAction: _gotoSubscribePage, buttonText: 'Subscribe');
    //return RaisedButton(onPressed: (){}, child: Text('Subscribe'));
  }

  _title() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Become a', style: TextStyle(color: Colors.white, fontSize: 45)),
          Text('Subscriber',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 45,
                  fontWeight: FontWeight.w800))
        ],
      ),
    );
  }

  _features() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _bulletPoints('Access to all Lessons'),
          _bulletPoints('Access to all Courses'),
          _bulletPoints('Other Exclusive Content')
        ],
      ),
    );
  }

  _bulletPoints(String message) {
    return Container(
      width: 250,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.check, color: Colors.green, size: 35),
          SizedBox(width: 25),
          Text(message,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }

  _buySubscriptionButton(context, buttonText, planId) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
        child: RaisedButton(
            padding: EdgeInsets.all(0),
            textColor: Colors.white,
            onPressed: () => Navigator.of(context)
                    .pushNamed(PaypalSubscription.PATH, arguments: {
                  'onFinish': _paymentOnFinish,
                  'planId': planId
                }), //_handlePayment(context),
            child: Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff247ae7), Color(0xff089ee2)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(buttonText),
                    //Icon(Icons.arrow_forward)
                  ],
                ))),
      ),
    );
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

  _paymentOnFinish(Map paymentResponse, planId) async {
    showLoadingDialog(context);

    if (paymentResponse["subscription_id"] != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      var startDate = formatter.format(DateTime.now());
      await _braineryUserService.createSubscriptionForUser(
          paymentResponse["subscription_id"], planId, startDate);
      setState(() {
        scenario = Scenario.PAYMENT_SUCCESS;
      });
    } else {
      setState(() => scenario = Scenario.PAYMENT_FAILURE);
    }
    Navigator.pop(context);
  }

  _termsAndPrivacy() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(Terms.PATH),
            child: Text('Terms', style: TextStyle(color: Colors.white))),
        SizedBox(width: 20),
        GestureDetector(  onTap: () => Navigator.of(context).pushNamed(Privacy.PATH), child: Text('Privacy', style: TextStyle(color: Colors.white)))
      ],
    );
  }

  _disclaimerMessage() {
    return Container(
        width: _width * 0.9,
        child: Text(
            'Your subscription will automatically be renewed unless turned off in Account setting at least 24 hours before the current period ends Payment is charged to your account.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center));
  }

  _cancelSubscription(subscriptionId) async {
    setState(() => _isLoading = true);
    _paypalServices
        .cancelPayPalSubscription(subscriptionId)
        .then((value) => cancelationSuccessAction())
        .catchError((error) => cancelationFailureAction());
  }

  _gotoSubscribePage() {
    print(">>> subscribe page");
    setState(() {
      showSubscriptionPage = true;
      scenario = Scenario.SUBSCRIPTION_PAGE;
    });
  }

  cancelationFailureAction() {
    Future<bool> dialogRef = showDialog(
        context: context,
        child: BraineryAlertDialog(
            title: 'Alert!',
            content:
                'Your request to cancel the subscription could not be handled. Please try again later.',
            confirmText: 'Ok'));
    dialogRef.then((value) {
      print('dialog closed');
      _braineryUserService.resetSubscriptionInfo();
      setState(() => _isLoading = false);
    });
  }

  cancelationSuccessAction() {
    Future<bool> dialogRef = showDialog(
        context: context,
        child: BraineryAlertDialog(
            title: 'Info!',
            content: 'Your subscription has been cancelled.',
            confirmText: 'Ok'));
    dialogRef.then((value) {
      print('dialog closed');
      _braineryUserService.resetSubscriptionInfo();
      setState(() => _isLoading = false);
    });
  }
}

enum Scenario { SUBSCRIPTION_PAGE, PAYMENT_FAILURE, PAYMENT_SUCCESS }
