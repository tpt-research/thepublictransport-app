import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:thepublictransport_app/pages/search/search.dart';
import 'package:thepublictransport_app/pages/nearby/nearby.dart';
import 'package:thepublictransport_app/pages/misc/settings.dart';
import 'package:flutter/services.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/pages/misc/firstrun.dart';
import 'package:thepublictransport_app/pages/misc/about.dart';

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
        accentColor: Colors.black
      ),
      home: getFirstRun(),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget getFirstRun() {
    if (PrefService.getBool("firstrun") == null ? true : false || PrefService.getBool("firstrun") == false) {
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
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark.copyWith(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Colors.black.withAlpha(30),
              systemNavigationBarColor: Colors.black,
              systemNavigationBarIconBrightness: Brightness.light
          )
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light.copyWith(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.white.withAlpha(30),
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark
          )
      );
    }
  }

  int changed = 0;
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

  @override
  void initState() {
    String start = PrefService.getString("start_page") ?? "None";

    switch (start) {
      case "Suche":
        changed = 0;
        break;
      case "In der Nähe":
        changed = 1;
        break;
      case "Pendlertools":
        changed = 2;
        break;
      default:
        changed = 0;
    }
  }
  
  StatefulWidget changePageByPosition() {
    switch (changed) {
      case 0:
        return SearchWidget();
        break;

      case 1:
        return NearbyWidget();
        break;

      default:
        return SearchWidget();
    }
  }

  @override
  Widget build(BuildContext context) {

    return new InnerDrawer(
      key: _innerDrawerKey,
      position: InnerDrawerPosition.end, // required
      onTapClose: true, // default false
      swipe: true, // default true
      offset: 0.6, // default 0.4
      colorTransition: Colors.black45, // default Color.black54
      animationType: InnerDrawerAnimation.quadratic, // default static
      innerDrawerCallback: (a) => print(a),
      child: Scaffold(
        backgroundColor: ColorThemeEngine.backgroundColor,
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  InkWell(
                    child: ListTile(
                      leading: new Icon(OMIcons.search, color: ColorThemeEngine.iconColor),
                      title: new Text(
                          "Suche",
                          style: new TextStyle(
                            color: ColorThemeEngine.textColor
                          ),
                      ),
                    ),
                    onTap: () {
                      _close();
                      changed = 0;
                      setState(() {

                      });
                    },
                  ),
                  InkWell(
                    child: ListTile(
                      leading: new Icon(OMIcons.locationOn, color: ColorThemeEngine.iconColor),
                      title: new Text(
                          "In der Nähe",
                        style: new TextStyle(
                            color: ColorThemeEngine.textColor
                        ),
                      ),
                    ),
                    onTap: () {
                      _close();
                      changed = 1;
                      setState(() {

                      });
                    },
                  ),
                  // Coming Soon
                  /*InkWell(
                    child: ListTile(
                      leading: new Icon(OMIcons.train),
                      title: new Text("Pendlertools"),
                    ),
                    onTap: () {
                      _close();
                      changed = 2;
                      setState(() {

                      });
                    },
                  ),*/
                  InkWell(
                    child: ListTile(
                      leading: new Icon(OMIcons.settings, color: ColorThemeEngine.iconColor),
                      title: new Text(
                          "Einstellungen",
                        style: new TextStyle(
                            color: ColorThemeEngine.textColor
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsWidget()));
                    },
                  )
                ],
              ),
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  InkWell(
                    child: ListTile(
                      leading: new Icon(OMIcons.info, color: ColorThemeEngine.iconColor),
                      title: new Text(
                        "Über die App",
                        style: new TextStyle(
                            color: ColorThemeEngine.textColor
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutPage()));
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 20))
                ],
              )
            ],
          ),
        ),
      ),
      scaffold: Scaffold(
        body: changePageByPosition(),
        floatingActionButton: CircularGradientButton(
          callback: (){
            _open();
          },
          child: Icon(Icons.menu),
          gradient: ColorThemeEngine.tptfabgradient,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BubbleBottomBar(
          iconSize: 32,
          opacity: .2,
          hasInk: true,
          hasNotch: ColorThemeEngine.theme == "light" ? true : false,
          fabLocation: BubbleBottomBarFabLocation.end,
          backgroundColor: ColorThemeEngine.backgroundColor,
          inkColor: ColorThemeEngine.backgroundColor,
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
            //Coming Soon
            /*BubbleBottomBarItem(
              backgroundColor: Colors.red,
              activeIcon: Icon(OMIcons.train, color: Colors.red[600]),
              icon: Icon(OMIcons.train, color: Colors.red[200]),
              title: new Text(
                'Pendlertools',
                style: new TextStyle(
                    color: Colors.red[600]
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  void _open()
  {
    _innerDrawerKey.currentState.open();
  }

  void _close()
  {
    _innerDrawerKey.currentState.close();
  }
}