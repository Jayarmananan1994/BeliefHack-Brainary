import 'package:brainery/service/PaypalService.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalSubscription extends StatefulWidget {
  static const String PATH = '/paypal-subscription';
  final Function onFinish;

  PaypalSubscription({this.onFinish});

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
            "P-72154846EA606791TL33WRWY", "Mani", "mani@gmail.com", true);
        if (approveObj != null) {
          print(">>>>Approve Obj " + approveObj.toString());
          setState(() {
            approveUrl = approveObj["href"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
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
          ? Center(child: CircularProgressIndicator())
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
          print('Payment done');
          print(uri.queryParameters);
          Navigator.of(context).pop();
          widget.onFinish(uri.queryParameters);
         // Navigator.of(context).pop();
        } else if (request.url.contains(cancelURL)) {
          print('Payment canceled>>>>>>>>>>');
          Navigator.of(context).pop();
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
