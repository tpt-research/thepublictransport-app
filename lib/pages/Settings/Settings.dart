import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thepublictransport_app/pages/About/About.dart';
import 'package:thepublictransport_app/pages/Start/Start.dart';
import 'package:thepublictransport_app/ui/components/OptionSwitch.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  _SettingsState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        statusBarColor: Colors.transparent, // status bar color
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROOOO",
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Einstellungen",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'NunitoSansBold'
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  new OptionSwitch(
                    title: "Datensparmodus",
                    subtitle: "Es werden dann nur noch wenige Vorschläge, Suchergebnisse und Verspätungsmeldungen geladen um den Datenverbrauch zu reduzieren.",
                    icon: Icons.save,
                    id: "datasave_mode",
                    default_bool: false,
                  ),
                  SizedBox(
                    height: 20.5,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 20.5,
                  ),
                  ListTile(
                    leading: new Icon(Icons.view_carousel),
                    title: new Text(
                      "Vorschau nochmals anschauen",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "NunitoSansBold"
                      ),
                    ),
                    subtitle: Text("Sehen sie sich nochmal die Vorschau an, die am Anfang präsentiert wurde."),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Start()));
                    },
                  ),
                  SizedBox(
                    height: 20.5,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 20.5,
                  ),
                  ListTile(
                    leading: new Icon(Icons.info),
                    title: new Text(
                      "Über diese App",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "NunitoSansBold"
                      ),
                    ),
                    subtitle: Text("Lernen sie die Personen kennen, die ihr bestes gegeben haben diese App zu präsentieren."),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => About()));
                    },
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
}
