import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Remnider extends StatefulWidget {
  static const String PATH = '/reminder';
  @override
  _RemniderState createState() => _RemniderState();
}

class _RemniderState extends State<Remnider> {
  bool _switchStatus = true;

  @override
  void initState() {
    getCurrentValueOfReimder().then((value) => setState(() => _switchStatus = value));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var textColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(title: Text('Reminder')),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Daily Meditation Reminder',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700)),
              trailing: Switch(
                  value: _switchStatus,
                  activeColor: Colors.green,
                  onChanged: (val) async {
                     SharedPreferences _preference = await SharedPreferences.getInstance();
                     _preference.setBool('remdinder_pref', val);
                    setState(() => _switchStatus = val);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> getCurrentValueOfReimder() async{
    SharedPreferences _preference = await SharedPreferences.getInstance();
    var reminderPref = _preference.getBool('remdinder_pref');
    return (reminderPref!=null) ?  reminderPref :  false;
  }
}
