import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/pages/Home/Home.dart';
import 'package:thepublictransport_app/ui/animations/ScaleUp.dart';
import 'package:thepublictransport_app/ui/animations/showup.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class Start extends StatefulWidget {
  Start({Key key}) : super(key: key) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black.withAlpha(30),
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light));
  }

  @override
  _StartState createState() => new _StartState();
}

class Welcome extends StatelessWidget {
  final List<List<IconData>> images = [
    [Icons.directions_bus, Icons.train, Icons.tram, Icons.directions_subway],
    [Icons.apps, Icons.phone_android, Icons.phone_iphone, Icons.tablet_android],
    [Icons.timelapse, Icons.timer_off, Icons.access_time, Icons.check],
    [Icons.search, Icons.near_me, Icons.location_on, Icons.my_location],
    [Icons.train, Icons.tram, Icons.directions_bus, Icons.directions_car],
  ];

  final List<String> titles = [
    "Hallo",
    "Wer sind wir?",
    "Unser Anspruch",
    "Alles in einer App",
    "Viel Spaß !"
  ];
  final List<String> subtitles = [
    "Willkommen bei The Public Transport. Zum Fortfahren, wischen sie bitte nach links.",
    "Wir sind The Public Transport. Die erste App für öffentlichen Verkehr in Flutter. Wir sind aber nicht nur eine App.",
    "Wir möchten den öffentlichen Verkehr verändern. Die Ära der Verspätungen und Unzuverlässigkeiten soll endlich enden! Deswegen bauen wir diese App, und was du in deinen Händen hältst ist erst der Anfang!!",
    "Wir möchten am liebsten alle Verkehrsmittel in diese App einbauen, und dies werden wir auch tun ! Und das in so vielen Ländern wie möglich !",
    "Für einen gemeinsamen öffentlichen Verkehr! Wir sind The Public Transport"
  ];

  final List<Color> backgroundColors = [
    new Color(0xffffffff),
    new Color(0xffffffff),
    new Color(0xffffffff),
    new Color(0xffffffff),
    new Color(0xffffffff)
  ];

  final List<bool> showButton = [false, false, false, false, true];

  final index;

  final locator = Geolocator();

  Welcome(this.index);

  @override
  Widget build(BuildContext context) {
    locator.checkGeolocationPermissionStatus();

    return new TransformerPageView(
      index: index,
      loop: false,
      transformer: new PageTransformerBuilder(
          builder: (Widget child, TransformInfo info) {
            return new ParallaxColor(
              colors: backgroundColors,
              info: info,
              child: new Column(
                children: <Widget>[
                  new Expanded(
                      child: new ParallaxContainer(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ShowUp(
                              delay: 100,
                              child: new Icon(
                                images[info.index][0],
                                color: Colors.black,
                                size: 100,
                              ),
                            ),
                            ShowUp(
                              delay: 200,
                              child: new Icon(
                                images[info.index][1],
                                color: Colors.black,
                                size: 100,
                              ),
                            ),
                            ShowUp(
                              delay: 300,
                              child: new Icon(
                                images[info.index][2],
                                color: Colors.black,
                                size: 100,
                              ),
                            ),
                            ShowUp(
                              delay: 400,
                              child: new Icon(
                                images[info.index][3],
                                color: Colors.black,
                                size: 100,
                              ),
                            ),
                          ],
                        ),
                        position: info.position,
                        opacityFactor: 1.0,
                        translationFactor: 400.0,
                      )),
                  new ParallaxContainer(
                    child: ScaleUp(
                      delay: 300,
                      duration: Duration(seconds: 1),
                      child: new Text(
                        titles[info.index],
                        style: new TextStyle(fontSize: 30.0, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    position: info.position,
                    translationFactor: 100.0,
                  ),
                  new ParallaxContainer(
                    child: new Padding(
                        padding: new EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 50.0),
                        child: ScaleUp(
                          delay: 400,
                          duration: Duration(seconds: 1),
                          child: new Text(subtitles[info.index],
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 13.0, color: Colors.black)),
                        )),
                    position: info.position,
                    translationFactor: 50.0,
                  ),
                  new Visibility(
                    visible: showButton[info.index],
                    child: new ParallaxContainer(
                      child: new Padding(
                        padding: new EdgeInsets.fromLTRB(40.0, 30.0, 40.0, 50.0),
                        child: new OutlineButton(
                            highlightElevation: 0,
                            borderSide: new BorderSide(
                                style: BorderStyle.solid,
                                width: 2,
                                color: Colors.black),
                            highlightedBorderColor: Colors.black,
                            child: Text('Fortfahren',
                                style: new TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 17,
                                    color: Colors.black)),
                            onPressed: () {
                              PrefService.setBool("firstrun", true);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
                            }),
                      ),
                      position: info.position,
                      translationFactor: 50.0,
                    ),
                  )
                ],
              ),
            );
          }),
      itemCount: 5,
    );
  }
}

class _StartState extends State<Start> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new Welcome(index),
          ),
        ],
      ),
    );
  }
}