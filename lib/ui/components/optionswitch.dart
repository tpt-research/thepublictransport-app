import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:preferences/preferences.dart';

class OptionSwitch extends StatefulWidget {
  OptionSwitch({@required this.title, @required this.icon, @required this.id, this.default_bool});

  final String title;
  final IconData icon;
  final String id;
  final bool default_bool;

  @override
  _OptionSwitchState createState() => _OptionSwitchState(this.title, this.icon, this.id, this.default_bool);
}

class _OptionSwitchState extends State<OptionSwitch> {
  _OptionSwitchState(this.title, this.icon, this.id, this.default_bool){
    if (this.default_bool != null) {
      if (PrefService.getBool(id) == null) {
        PrefService.setBool(id, this.default_bool);
      }
    }
  }

  final String title;
  final IconData icon;
  final String id;
  final bool default_bool;

  bool isSwitched = false;

  Future<bool> getSwitched() async {
    if (PrefService.getBool(id) != null)
      return PrefService.getBool(id);
    else
      return false;
  }

  setSwitched(value) async {
    PrefService.setBool(id, value);
  }

  Widget build(BuildContext context){
    return new ListTile(
      leading: new Icon(this.icon, color: ColorThemeEngine.iconColor),
      title: new Text(
        this.title,
        style: TextStyle(
            color: ColorThemeEngine.textColor
        ),
      ),
      trailing: Switch(
        value: PrefService.getBool(id),
        onChanged: (value) {
          setState(() {
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




}