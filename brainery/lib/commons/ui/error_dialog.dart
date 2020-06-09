import 'package:flutter/material.dart';

class ErrorDialogue extends StatelessWidget {
  final String errorMsg;

  ErrorDialogue({@required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Dialog(
            child: Card(
                child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              width: 300,
              //height: 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Oops!',
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor)),
                  SizedBox(height: 5),
                  Text(errorMsg),
                  RaisedButton(
                      onPressed: () => Navigator.pop(context),
                      color: Theme.of(context).primaryColor,
                      child: Text('Okay', style: TextStyle(color: Colors.white),))
                ],
              ),
            )),
          );
  }
}