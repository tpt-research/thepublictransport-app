import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptscaffold.dart';

class SettingsWidget extends StatefulWidget {
  @override
  SettingsWidgetState createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  Widget build(BuildContext context) {
    return TPTScaffold(
      title: "Einstellungen",
      body: Container(
          child: Center(
            child: Text('Test3'),
          )
      ),
    );
  }
}