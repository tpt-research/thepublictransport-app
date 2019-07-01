import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/pages/misc/firstrun.dart';
import 'package:thepublictransport_app/pages/search/search.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

void main() async {
  await PrefService.init(prefix: 'pref_settings_');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Public Transport',
      theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.black,
          fontFamily: 'Nunito'),
      home: getFirstRun(),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget getFirstRun() {
    if (PrefService.getBool("firstrun") == null
        ? true
        : false || PrefService.getBool("firstrun") == false) {
      firstInit();
      return FirstrunPage();
    } else {
      return SplashScreen();
    }
  }

  firstInit() {
    PrefService.setBool("long_distance_trains", true);
    PrefService.setBool("regional_trains", true);
    PrefService.setBool("local_trains", true);
    PrefService.setBool("local_vehicles", true);
  }
}

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenState() {
    if (ColorThemeEngine.theme == "dark") {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Colors.black.withAlpha(30),
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white.withAlpha(30),
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SearchWidget();
  }
}
