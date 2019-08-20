import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';

import 'package:thepublictransport_app/pages/Home/Home.dart';

void main() async {
  await PrefService.init(prefix: 'pref_settings_');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark
  ));

  runApp(Boot());
}


class Boot extends StatefulWidget {
  @override
  _BootState createState() => _BootState();
}

class _BootState extends State<Boot> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Public Transport',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'NunitoSans'
      ),
      home: Home(),
    );
  }
}

