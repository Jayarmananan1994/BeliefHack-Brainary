import 'package:brainery/commons/ui/brainery_alert_dialog.dart';
import 'package:brainery/commons/validators.dart';
import 'package:brainery/service/brainery_user_service.dart';
import 'package:brainery/service_locator.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  static const String PATH = '/help';

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  String helpMessage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  BraineryUserService _userService = locator<BraineryUserService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HELP')),
      body: Container(
        //color: Color(0xff2b4185),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20),
                child: Text(getInfoText(),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xff2b4185)))),
            Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    onSaved: (val) => helpMessage = val,
                    validator: validateHelpMessage,
                    decoration: InputDecoration(
                        hintText: 'Enter your message',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 5.0),
                        ))),
              ),
            ),
            submitQueryButton(context),
          ],
        ),
      ),
    );
  }

  getInfoText() {
    return "Dolor sit amet consectetur adipiscing elit duis tristique. A scelerisque purus semper eget duis at tellus at urna. Tellus id interdum velit laoreet.";
  }

  submitQueryButton(context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        buttonColor: Color(0xff089ee2),
        height: 50,
        child: RaisedButton(
            padding: EdgeInsets.all(0),
            textColor: Colors.white,
            onPressed: _sendHelpMessage, //_handlePayment(context),
            child: Container(child: Text('SEND'))),
      ),
    );
  }

  _sendHelpMessage() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //showLoadingDialog();
      _userService.postHelpMessageFromUser(helpMessage).then((value) {
        print("Value");
        print(value);
        showDialog(
            context: context,
            child: BraineryAlertDialog(
              title: 'Success!',
              content:
                  'Your message has been submitted. The team will reach you soon.',
              confirmText: 'Ok'
            ));
      }).catchError(helpErrorHandler);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  helpErrorHandler(error) {
    print("err");
    print(error.toString());
  }
}
