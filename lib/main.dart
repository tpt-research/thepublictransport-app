import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:thepublictransport_app/pages/search.dart';
import 'package:thepublictransport_app/pages/nearby.dart';
import 'package:thepublictransport_app/pages/settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Public Transport',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  int changed = 0;
  
  StatefulWidget changePageByPosition() {
    switch (changed) {
      case 0:
        return SearchWidget();
        break;
        
      case 1:
        return NearbyWidget();
        break;
        
      case 2:
        return SettingsWidget();
        break;

      default:
        return SearchWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: changePageByPosition(),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.black,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey[400],
        tabs: [
          TabData(iconData: Icons.search, title: "Suche"),
          TabData(iconData: Icons.location_on, title: "In der Nähe"),
          TabData(iconData: Icons.settings, title: "Einstellungen")
        ],
        onTabChangedListener: (position) {
          setState(() {
            changed = position;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
