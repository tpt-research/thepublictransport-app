import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:thepublictransport_app/pages/search.dart';
import 'package:thepublictransport_app/pages/nearby.dart';
import 'package:thepublictransport_app/pages/settings.dart';
import 'package:flutter/services.dart';
import 'package:thepublictransport_app/ui/colors/colorconstants.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

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
      bottomNavigationBar: BubbleBottomBar(
        iconSize: 32,
        opacity: .2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        currentIndex: changed,
        onTap: (int index) {
          setState(() {
            changed = index;
          });
        },
        items: [
          BubbleBottomBarItem(
            backgroundColor: Colors.purple,
            activeIcon: Icon(OMIcons.search, color: Colors.purple[600]),
            icon: new Icon(OMIcons.search, color: Colors.purple[200]),
            title: new Text(
              'Suche',
              style: new TextStyle(
                  color: Colors.purple[600]
              ),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.blue,
            activeIcon: Icon(OMIcons.locationOn, color: Colors.blue[600]),
            icon: Icon(OMIcons.locationOn, color: Colors.blue[200]),
            title: new Text(
              'In der Nähe',
              style: new TextStyle(
                  color: Colors.blue[600]
              ),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.pink,
            activeIcon: Icon(OMIcons.settings, color: Colors.pink[600]),
            icon: Icon(OMIcons.settings, color: Colors.pink[200]),
            title: Text(
              'Einstellungen',
              style: new TextStyle(
                color: Colors.pink[600]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
