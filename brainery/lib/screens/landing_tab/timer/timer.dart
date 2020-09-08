import 'package:brainery/screens/landing_tab/timer/timer_start.dart';
import 'package:flutter/material.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  double viewPortFraction = 0.5;

  double pageOffset = 0;
  int minute = 5;
  int intervalSelected = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _timer(),
          _beginButton(),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: _addIntervalButton())
        ],
      ),
    );
  }

  _timer() {
    return Container(
      // height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
              elevation: 5,
              onPressed: (minute == 5) ? null : _minusMinutes,
              child: Icon(Icons.remove)),
          Container(child: Text(minute.toString())),
          RawMaterialButton(
              elevation: 5,
              onPressed: (minute >= 20) ? null : _addMinutes,
              child: Icon(Icons.add))
        ],
      ),
    );
  }

  _addMinutes() {
    setState(() => minute = minute + 1);
  }

  void _minusMinutes() {
    setState(() => minute = minute - 1);
  }

  _beginButton() {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: _startAlarm,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff247ae7), Color(0xff089ee2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 500.0, minHeight: 100.0),
            alignment: Alignment.center,
            child: Text(
              "BEGIN",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  _addIntervalButton() {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: () => PlatformActionSheet().displaySheet(
            context: context,
            message: Text("Select interval"),
            actions: [1, 2, 3, 4, 'Cancel'].map((element) {
              return ActionSheetAction(
                  text: (element.toString() == 'Cancel')
                      ? 'Cancel'
                      : element.toString() + " Minutes",
                  onPressed: () => (element.toString() == 'Cancel')
                      ? _setInterval(0)
                      : _setInterval(element),
                  hasArrow: (element.toString() != 'Cancel'),
                  isCancel: (element.toString() == 'Cancel'),
                  defaultAction: (element.toString() == 'Cancel'));
            }).toList()),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 500.0, minHeight: 100.0),
            alignment: Alignment.center,
            child: Text(
              (intervalSelected == 0)
                  ? "ADD INTERVAL"
                  : intervalSelected.toString() + " Minutes interval",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff089ee2)),
            ),
          ),
        ),
      ),
    );
  }

  _setInterval(minute) {
    setState(() => intervalSelected = minute);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startAlarm() async {
    Map arg = {"totalSeconds": minute * 60, "interval": intervalSelected * 60};
    Navigator.of(context).pushNamed(TimerStart.PATH, arguments: arg);
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return SafeArea(
    //             child: TimerStart(
    //           totalSeconds: minute*60,
    //           interval: intervalSelected,
    //         ));
    //       },
    //       isDismissible: false,
    //       isScrollControlled: true);
  }
}
