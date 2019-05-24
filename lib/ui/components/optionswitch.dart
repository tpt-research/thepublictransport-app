import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class OptionSwitch extends StatefulWidget {
  OptionSwitch({@required this.title, @required this.icon, @required this.id});

  final String title;
  final IconData icon;
  final String id;

  @override
  _OptionSwitchState createState() => _OptionSwitchState(this.title, this.icon, this.id);
}

class _OptionSwitchState extends State<OptionSwitch> {
  _OptionSwitchState(this.title, this.icon, this.id);

  final String title;
  final IconData icon;
  final String id;

  bool isSwitched = false;

  Future<bool> getSwitched() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getBool(id + "_pref") != null)
      return _prefs.getBool(id + "_pref");
    else
      return false;
  }

  setSwitched(value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(id + "_pref", value);
  }

  Widget build(BuildContext context){
    return new FutureBuilder<bool>(
      future: getSwitched(),
      builder: (BuildContext context,
          AsyncSnapshot<bool> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
          case ConnectionState.waiting:
            return new ListTile(
              leading: new Icon(this.icon),
              title: new Text(this.title),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    setSwitched(value);
                  });
                },
                activeTrackColor: Colors.purpleAccent,
                activeColor: Colors.purple,
              ),
            );
          case ConnectionState.none:
            return new Container();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text("Failed reading shared preference");
            }

            isSwitched = snapshot.data;

            return new ListTile(
              leading: new Icon(this.icon, color: ColorThemeEngine.iconColor),
              title: new Text(
                  this.title,
                  style: TextStyle(
                    color: ColorThemeEngine.textColor
                  ),
              ),
              trailing: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    setSwitched(value);
                  });
                },
                activeTrackColor: Colors.purpleAccent,
                activeColor: Colors.purple,
                inactiveTrackColor: Colors.grey[200],
                inactiveThumbColor: Colors.grey[300],
              ),
            );
        }
        return null; // unreachable
      },
    );
  }




}