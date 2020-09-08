import 'package:flutter/material.dart';

class BraineryButton extends StatelessWidget {
  final Function buttonAction;
  final String buttonText;

  const BraineryButton({Key key, this.buttonAction, this.buttonText}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
        child: RaisedButton(
            padding: EdgeInsets.all(0),
            textColor: Colors.white,
            onPressed: buttonAction, //_handlePayment(context),
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
}