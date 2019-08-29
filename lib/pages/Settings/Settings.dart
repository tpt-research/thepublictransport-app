import 'package:flutter/material.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/About/About.dart';
import 'package:thepublictransport_app/pages/Start/Start.dart';
import 'package:thepublictransport_app/ui/components/OptionSwitch.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      floatingActionButton: FloatingActionButton(
        heroTag: "HEROOOO",
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: theme.floatingActionButtonColor,
        child: Icon(Icons.arrow_back, color: theme.floatingActionButtonIconColor),
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
                          color: theme.titleColor,
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
                  new OptionSwitch(
                    title: "Dunkles Design",
                    subtitle: "Spart besonders Energie bei OLED Displays und sieht für diverse User ästhetisch aus. Um die Änderungen wirksam zu machen, starten sie die App neu.",
                    icon: Icons.settings_brightness,
                    id: "theme_mode",
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
                    leading: new Icon(Icons.view_carousel, color: theme.iconColor),
                    title: new Text(
                      "Vorschau nochmals anschauen",
                      style: TextStyle(
                          color: theme.titleColor,
                          fontFamily: "NunitoSansBold"
                      ),
                    ),
                    subtitle: Text(
                        "Sehen sie sich nochmal die Vorschau an, die am Anfang präsentiert wurde.",
                        style: TextStyle(
                            color: theme.subtitleColor
                        ),
                    ),
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
                    leading: new Icon(Icons.info, color: theme.iconColor),
                    title: new Text(
                      "Über diese App",
                      style: TextStyle(
                          color: theme.titleColor,
                          fontFamily: "NunitoSansBold"
                      ),
                    ),
                    subtitle: Text(
                        "Lernen sie die Personen kennen, die ihr bestes gegeben haben diese App zu präsentieren.",
                        style: TextStyle(
                          color: theme.subtitleColor
                        ),
                    ),
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
