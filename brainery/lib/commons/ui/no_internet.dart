import 'package:brainery/commons/validators.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatefulWidget {
  final Function retry;

  NoInternet({this.retry});

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  bool retryInProgress = false;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _height,
      width: _width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          (retryInProgress) ? _tryReconnectMessage(): _noInternetMessage(),
          RaisedButton(onPressed: (retryInProgress) ? null : _checkInternetConnectivity, child: Text('Retry'),)
        ],
      ),
    );
  }

  _noInternetMessage(){
    return Container(
      child: Column(
        children: <Widget>[
           Text('Ooops!'),
          Text('NO Internet Connection Found'),
          Text('Check your connection'),
        ],
      ),
    );
  }

  _tryReconnectMessage(){
    return Container(
      child: Text('Checking the internet again'),
    );
  }

  _checkInternetConnectivity() async {
    setState(() {
      retryInProgress = true;
    });
    bool isConnected = await isConnectedToIntetnet();
    if(isConnected){
      widget.retry();
    } else{
        setState(() {
      retryInProgress = false;
    });
    }
  }
}