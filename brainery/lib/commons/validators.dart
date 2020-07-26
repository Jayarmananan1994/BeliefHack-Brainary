import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';

String validateName(String value) {
  return (value.length < 3) ? 'Name must be more than 3 charater' : null;
}

String validateHelpMessage(String value) {
  return (value.length == 0) ? 'The message cannot be empty' : null;
}

String validatePassword(String value) {
  return (value.length < 3) ? 'Password must have atleast 3 charater' : null;
}

String validateMobile(String value) {
  return (value.length != 10) ? 'Mobile Number must be of 10 digit' : null;
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);

  return (!regex.hasMatch(value)) ? 'Enter Valid Email' : null;
}

Future<bool> isConnectedToIntetnet() async {
  var connectivityResult =
      await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.wifi ||
      connectivityResult == ConnectivityResult.mobile) {
    print('It is connected to wifi');
    try {
      final result = await InternetAddress.lookup('example.com').timeout(Duration(seconds: 15));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }else{
        return false;
      }
    } on SocketException catch (_) {
     return false;
    } on TimeoutException catch(_) {
      return false;
    }
  } else {
    return false;
  }
}
