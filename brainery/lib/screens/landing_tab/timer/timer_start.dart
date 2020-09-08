import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:brainery/commons/ui/brainery_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class TimerStart extends StatefulWidget {
  static const String PATH = '/timer-start';
  final int totalSeconds;
  final int interval;
  const TimerStart({Key key, this.totalSeconds, this.interval})
      : super(key: key);
  @override
  _TimerStartState createState() => _TimerStartState();
}

class _TimerStartState extends State<TimerStart> {
  String _minutes = '00';
  String _seconds = '00';
  StreamSubscription<CountdownTimer> _sub;
  bool _onDone = false;
  int _intervalTimeLapsed = 0;
  AudioCache _audioCache = new AudioCache();

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _hardwareBack,
      child: Scaffold(
        body: Container(
          color: Color(0xff2c4083),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: _back)
                  ]),
              // SizedBox(height: 20),
              SizedBox(height: 20),
              _createTimerView(),
              SizedBox(height: 20),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _hardwareBack() async {
    if (!_onDone) {
      bool value = await showExitConfirmDialog();
      if (value) {
        _sub.cancel();
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  _back() {
    if (!_onDone) {
      Future<bool> dialogRef = showExitConfirmDialog();
      dialogRef.then((value) {
        if (value) {
          _sub.cancel();
          Navigator.of(context).pop();
        }
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<bool> showExitConfirmDialog() {
    return showDialog(
        context: context,
        child: BraineryAlertDialog(
            title: 'Alert!',
            content:
                'The timer is still in progress.Are you sure you want to go back?\n The timer will stop',
            confirmText: 'Ok',
            cancelText: 'Cancel'));
  }

  _createTimerView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_minutes, style: TextStyle(color: Colors.white, fontSize: 50)),
        Text(':', style: TextStyle(color: Colors.white, fontSize: 50)),
        Text(_seconds, style: TextStyle(color: Colors.white, fontSize: 50))
      ],
    );
  }

  _startTimer() {
    _setValueForTimer(widget.totalSeconds);
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: widget.totalSeconds),
      new Duration(seconds: 1),
    );

    _sub = countDownTimer.listen(null);
    _sub.onData((duration) {
      setState(() {
        if (widget.interval > 0) _intervalTimeLapsed += 1;

        var current = widget.totalSeconds - duration.elapsed.inSeconds;
        if (widget.interval > 0 && widget.interval == _intervalTimeLapsed) {
          _intervalTimeLapsed = 0;
          _raiseAlarm();
        }
        print("Current:" +
            current.toString() +
            " and timeLapsed :" +
            _intervalTimeLapsed.toString());
        _setValueForTimer(current);
      });
    });

    _sub.onDone(() {
      print("Done");
      _onDone = true;
      _audioCache.play('sounds/clock.mp3');
      _sub.cancel();
    });
  }

  _setValueForTimer(secondsToDisplay) {
    int seconds = secondsToDisplay % 60;
    int minutes = ((secondsToDisplay - seconds) / 60).round();
    setState(() {
      _minutes = (minutes < 10) ? '0' + minutes.toString() : minutes.toString();
      _seconds = (seconds < 10) ? '0' + seconds.toString() : seconds.toString();
    });
  }

  void _raiseAlarm() {
    //_intervalToPlaying = true;
    print('>>> Raise alarm....');
    // _audioPlayer.play( 'sounds/clock.mp3', isLocal: true);
    // _audioPlayer.onPlayerCompletion.listen((event) {
    //     _intervalToPlaying = false;
    // })
    _audioCache.play('sounds/mini_clock.mp3');
  }
}
