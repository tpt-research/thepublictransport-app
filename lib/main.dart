import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:thepublictransport_app/pages/search.dart';
import 'package:thepublictransport_app/pages/nearby.dart';
import 'package:thepublictransport_app/pages/settings.dart';
import 'package:flutter/services.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white.withAlpha(30)
    ));
    return MaterialApp(
      title: 'The Public Transport',
      theme: ThemeData(),
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
      /*bottomNavigationBar: FancyBottomNavigation(
        circleColor: ColorConstants.fancybottomcolor,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey[400],
        barBackgroundColor: Colors.white,
        textColor: Colors.black,
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
      ), // This trailing comma makes auto-formatting nicer for build methods.*/
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: changed,
        onTap: (int index) {
          setState(() {
            changed = index;
            changed = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(OMIcons.search, color: Colors.black),
            icon: new Icon(OMIcons.search, color: Colors.grey[400]),
            title: new Text(
              'Suche',
              style: new TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(OMIcons.locationOn, color: Colors.black),
            icon: Icon(OMIcons.locationOn, color: Colors.grey[400]),
            title: new Text(
              'In der Nähe',
              style: new TextStyle(
                  color: Colors.black
              ),
            ),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(OMIcons.settings, color: Colors.black),
            icon: Icon(OMIcons.settings, color: Colors.grey[400]),
            title: Text(
              'Einstellungen',
              style: new TextStyle(
                color: Colors.black
              ),
            ),
          ),
        ],
      ),
    );
  }
}
