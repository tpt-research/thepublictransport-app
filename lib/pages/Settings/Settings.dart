import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:preferences/preferences.dart';
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
                    icon: Icons.data_usage,
                    id: "datasave_mode",
                    default_bool: true,
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
                  new OptionSwitch(
                    title: "Firebase Analytics",
                    subtitle: "Sammelt Anonyme Daten über Nutzerverhalten an uns, die uns dabei helfen unsere App zu verbessern. Firebase Analytics ist ein Service von Google LLC.",
                    icon: MaterialCommunityIcons.google_analytics,
                    id: "analytics_mode",
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
                    title: "Firebase Crashlytics",
                    subtitle: "Sammelt Abstürze der App und gibt sie an uns weiter, damit wir die App verbessern können. Firebase Crashlytics ist ein Service von Fabric.io (Alphabet Inc.).",
                    icon: MaterialCommunityIcons.home_analytics,
                    id: "crashlytics_mode",
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
                    leading: new Icon(Icons.directions_bus, color: theme.iconColor),
                    title: new Text(
                      "Datenbestand wechseln",
                      style: TextStyle(
                          color: theme.titleColor,
                          fontFamily: "NunitoSansBold"
                      ),
                    ),
                    subtitle: Text(
                      "Hier können sie auswählen von welchem Verkehrsbund die Daten kommen sollen. Beim Wechseln des Verkehrsbundes werden diverse Features deaktiviert.",
                      style: TextStyle(
                          color: theme.subtitleColor
                      ),
                    ),
                    onTap: () {
                      showDataDialog();
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
                  SizedBox(
                    height: 100,
                  )
                ],
              )
          )
        ],
      ),
    );
  }
  
  void showDataDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)
            ),
            content: SizedBox(
              width: MediaQuery.of(this.context).size.width * 0.98,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  generateListTile(
                      "Deutsche Bahn",
                      "Beinhaltet Daten des Deutschen Nah- und Fernverkehrs, inklusive Internationale Daten und von vielen Verkehrsbünden",
                      'https://upload.wikimedia.org/wikipedia/commons/d/d5/Deutsche_Bahn_AG-Logo.svg',
                      'DB',
                      context
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  generateListTile(
                      "Rhein-Main Verkehrsbund",
                      "Beinhaltet Daten des RMV Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/0/0d/Rhein-Main-Verkehrsverbund_logo.svg',
                      'NVV_RMV',
                      context
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  generateListTile(
                      "Berliner Verkehrsbetriebe",
                      "Beinhaltet Daten des BVG Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/d/d4/Bvg-logo.svg',
                      'BVG',
                      context
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  generateListTile(
                      "Karlsruher Verkehrsbund",
                      "(Experimentell) Beinhaltet Daten des KVV Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/e/e3/KVV_2010.svg',
                      'KVV',
                      context
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  generateListTile(
                      "Verkehrsbund Rhein-Ruhr",
                      "(Experimentell) Beinhaltet Daten des VRR Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/9/9d/Verkehrsverbund_Rhein-Ruhr_2010_logo.svg',
                      'VRR',
                      context
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  generateListTile(
                      "Wiener Linien",
                      "(Experimentell) Beinhaltet Daten der österreichischen Wiener Linien",
                      'https://upload.wikimedia.org/wikipedia/commons/5/59/Wiener_Linien_logo.svg',
                      'Wien',
                      context
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  generateListTile(
                      "Österreichische Bundesbahnen",
                      "(Teils Stabil) Beinhaltet Daten der österreichischen Bundesbahn",
                      'https://upload.wikimedia.org/wikipedia/commons/5/5e/Logo_%C3%96BB.svg',
                      'OEBB',
                      context
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  generateListTile(
                      "Schweizerische Bundesbahnen",
                      "(Experimentell) Beinhaltet Daten der schweizerischen Bundesbahn",
                      'https://upload.wikimedia.org/wikipedia/commons/0/00/Sbb-logo.svg',
                      'SBB',
                      context
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Schließen", style: TextStyle(color: theme.textColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  ListTile generateListTile(String title, String subtitle, String imageURL, String ID, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: theme.titleColor,
            fontFamily: "NunitoSansBold"
        ),
      ),
      subtitle: Text(subtitle),
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Center(child: SvgPicture.network(imageURL)),
      ),
      trailing: Icon(
          PrefService.getString('public_transport_data') == ID ? Icons.radio_button_checked : Icons.radio_button_unchecked
      ),
      onTap: () {
        PrefService.setString('public_transport_data', ID);
        Navigator.of(context).pop();
      },
    );
  }
}
