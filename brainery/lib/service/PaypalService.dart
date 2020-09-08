import 'package:brainery/commons/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;
import 'package:http_auth/http_auth.dart';

class PaypalServices {
  String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
//  String domain = "https://api.paypal.com"; // for production mode

  // change clientId and secret with your own, provided by paypal
  String clientId =
      'AQB3F1i5hWCFMDx6I2xb6OeWdLcdYxucuiYl7JAYXhG-4ejFTybV-yYK2y_ect1vPRMNiVPiaBxCS-pb';
  String secret =
      'EJytTam81ru3LeBkLqnAaQM__ywgcmhoet4TPXK0Jh53PUxCMkE1cb6IVr4GiRSeVJsF9Qq8WjLw1GDk';

  // for getting the access token from Paypal
  Future<String> getAccessToken() async {
    try {
      var client = BasicAuthClient(clientId, secret);
      var response = await client
          .post('$domain/v1/oauth2/token?grant_type=client_credentials');
      if (response.statusCode == 200) {
        final body = convert.jsonDecode(response.body);
        return body["access_token"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // for creating the payment request with Paypal
  Future<Map<String, String>> createPaypalPayment(
      transactions, accessToken) async {
    try {
      var response = await http.post("$domain/v1/payments/payment",
          body: convert.jsonEncode(transactions),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (body["links"] != null && body["links"].length > 0) {
          List links = body["links"];

          String executeUrl = "";
          String approvalUrl = "";
          final item = links.firstWhere((o) => o["rel"] == "approval_url",
              orElse: () => null);
          if (item != null) {
            approvalUrl = item["href"];
          }
          final item1 = links.firstWhere((o) => o["rel"] == "execute",
              orElse: () => null);
          if (item1 != null) {
            executeUrl = item1["href"];
          }
          return {"executeUrl": executeUrl, "approvalUrl": approvalUrl};
        }
        return null;
      } else {
        throw Exception(body["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }

  // for executing the payment transaction
  Future<String> executePayment(url, payerId, accessToken) async {
    try {
      var response = await http.post(url,
          body: convert.jsonEncode({"payer_id": payerId}),
          headers: {
            "content-type": "application/json",
            'Authorization': 'Bearer ' + accessToken
          });

      final body = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        return body["id"];
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map> createPayPalSubscription(
      planId, name, emailId, autorenewal) async {
    try {
      var requestBody =
          _createPaypalRequestBody(planId, name, emailId, autorenewal);
      var response = await http.post(PAYPAL_SUBSCRIPTION_URL,
          body: convert.jsonEncode(requestBody),
          headers: {"content-type": "application/json"});
      final Map body = convert.jsonDecode(response.body);
      if (body["status"] == "APPROVAL_PENDING") {
        List links = body["links"];
        Map approveObj =
            links.firstWhere((element) => element["rel"] == "approve");
        return approveObj;
      } else {
        throw Exception("Error in payment");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map> cancelPayPalSubscription(subcriptionId) async {
    try {
      var response = await http.get(
          PAYPAL_CANCEL_SUBSCRIPTION_URL + '/' + subcriptionId);
      final Map body = convert.jsonDecode(response.body);
      if (body["response"] == "success") {
        return body;
      } else {
        throw Exception("Error in payment");
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Map<String, dynamic> _createPaypalRequestBody(
      planId, name, emailId, autorenewal) {
    return {
      "planId": planId,
      "subscriber": {
        "name": {"given_name": name},
        "email_address": emailId
      },
      "autorenewal": autorenewal
    };
  }
}
