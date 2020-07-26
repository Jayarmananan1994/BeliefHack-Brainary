import 'package:brainery/commons/ui/brainery_alert_dialog.dart';
import 'package:brainery/service/PaypalService.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalSubscription extends StatefulWidget {
  static const String PATH = '/paypal-subscription';
  final Function onFinish;
  final String planId;

  PaypalSubscription({this.onFinish, this.planId});

  @override
  _PaypalSubscriptionState createState() => _PaypalSubscriptionState();
}

class _PaypalSubscriptionState extends State<PaypalSubscription> {
  String returnURL = 'http://zoho.com/returnUrl';
  String cancelURL = 'http://zoho.com/cancelUrl';
  String approveUrl;
  PaypalServices services = PaypalServices();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      try {
        Map approveObj = await services.createPayPalSubscription(
            widget.planId, "Mani", "mani@gmail.com", true);
        if (approveObj != null) {
          setState(() {
            approveUrl = approveObj["href"];
          });
        }
      } catch (e) {
        closeWindowWithWaring();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Payment'),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          )),
      body: (approveUrl == null)
          ? Center(child: Column( children: <Widget>[
            Text('Please wait, we are redirecting you to the paypal payment.'),
            CircularProgressIndicator()
          ],) )
          : paymentWebView(),
    );
  }

  Widget paymentWebView() {
    print(">>>>>Building the web view" + approveUrl);
    return WebView(
      initialUrl: approveUrl,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        if (request.url.contains(returnURL)) {
          final uri = Uri.parse(request.url);
          Navigator.of(context).pop();
          widget.onFinish(uri.queryParameters, widget.planId);
        } else if (request.url.contains(cancelURL)) {
          Navigator.of(context).pop();
        }
        return NavigationDecision.navigate;
      },
    );
  }

  void closeWindowWithWaring() async{
    await BraineryAlertDialog(
            title: 'Oops!',
            content:
                'We could not complete the payment. Please try again later.',
            confirmText: 'Ok').show(context);
    Navigator.of(context).pop();
  }
}
