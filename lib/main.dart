import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:thepublictransport_app/pages/Home/Home.dart';
import 'package:thepublictransport_app/pages/Start/Start.dart';

void main() async {
  await PrefService.init(prefix: 'pref_settings_');
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
        fontFamily: 'NunitoSans',
      ),
      home: getSplashRun(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('de'), // Deutsch
      ],
    );
  }

  Widget getSplashRun() {
    if (PrefService.getBool("firstrun") == null ? true : false || PrefService.getBool("firstrun") == false) {
      return Start();
    } else {
      return Home();
    }
  }
}

