import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff136a8a),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff136a8a),
            ),
            height: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.34,
            child: Center(
              child: Text(
                "Einstellungen",
                style: TextStyle(
                    fontFamily: 'NunitoSansBold',
                    fontSize: 40,
                    color: Colors.white
                ),
              ),
            ),
          ),
          Flexible(
              child: ClipRRect(
                borderRadius: radius,
                child: Container(
                  height: double.infinity,
                  color: theme.backgroundColor,
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
                        onTap: () async {
                          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => About()));

                          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                            systemNavigationBarColor: Colors.blueAccent,
                            statusBarColor: Colors.transparent, // status bar color
                            statusBarBrightness: Brightness.light,
                            statusBarIconBrightness: Brightness.light,
                          ));
                        },
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
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
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Deutschland",
                    style: TextStyle(
                      fontFamily: 'NunitoSansBold',
                      color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                      "Aachener Verkehrsverbund",
                      "Beinhaltet Daten des AVV Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/c/cf/AVV_Logo_neu.svg',
                      'AVVAachen',
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
                  generateListTilePNG(
                      "INSA (Sachsen / Sachsen-Anhalt)",
                      "Beinhaltet Daten des INSA Nahverkehrs",
                      'https://www.starker-nahverkehr.de/fileadmin/templates/img/insa/insa-logo.png',
                      'NASA',
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
                      "Verkehrsverbund Bremen/Niedersachsen",
                      "Beinhaltet Daten des VBN Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/b/b9/Logo_Verkehrsverbund_Bremen_Niedersachsen.svg',
                      'VBN',
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
                      "Verkehrsmanagement-Gesellschaft Saar",
                      "Beinhaltet Daten des VGS Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/4/4e/VerkehrsmanagementGesellschaft_Saar_logo.svg',
                      'VGS',
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
                      "Verkehrsverbund Mittelthüringen",
                      "Beinhaltet Daten des VMT Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/5/56/Verkehrsverbund_Mittelth%C3%BCringen_logo.svg',
                      'VMT',
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
                      "Ingolstädter Verkehrsgesellschaft",
                      "Beinhaltet Daten des INVG Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/de/0/09/Ingolst%C3%A4dter_Verkehrsgesellschaft_Logo.svg',
                      'INVG',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Schweiz",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTile(
                      "Zürcher Verkehrsverbund",
                      "Beinhaltet Daten des ZVV Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/2/2b/Logo_ZVV.svg',
                      'ZVV',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Luxemburg",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTile(
                      "Verkéiersverbond Luxembourg",
                      "Beinhaltet Daten des Luxemburger Nahverkehrs",
                      'https://www.mobiliteit.lu/wp-content/themes/mobiliteit/assets/img/mobiliteit-logo.svg',
                      'LU',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Belgien",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTile(
                      "Nationale Gesellschaft der Belgischen Eisenbahnen",
                      "Beinhaltet Daten der Belgischen Bahn",
                      'https://upload.wikimedia.org/wikipedia/commons/9/9d/LogoBR.svg',
                      'SNCB',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Dänemark",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTilePNG(
                      "Danske Statsbaner",
                      "Beinhaltet Daten des Dänischen Nahverkehrs",
                      'https://upload.wikimedia.org/wikipedia/commons/a/a3/Danske_Statsbaner_logo2014.png',
                      'DSB',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Österreich",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTilePNG(
                      "VOR AnachB (Österreich)",
                      "Beinhaltet Daten des VOR AnachB Netzwerkes",
                      'https://anachb.vor.at/hafas-res/img/vs_voranachb/logo_voranachb_small_new.png',
                      'AnachB',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Großbritannien",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTilePNG(
                      "Arriva UK",
                      "Beinhaltet Daten des Arriva UK Netzwerkes",
                      'https://upload.wikimedia.org/wikipedia/commons/3/3f/New_Logo_Arriva.png',
                      'ArrivaUK',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "USA / Kalifornien",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTile(
                      "Bay Area Rapid Transit (San Francisco)",
                      "Beinhaltet Daten des BART Netzwerkes",
                      'https://upload.wikimedia.org/wikipedia/commons/2/26/Bart-logo.svg',
                      'BART',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Irrland",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTilePNG(
                      "Iarnród Éireann (Irrland)",
                      "Beinhaltet Daten der Staatsbahn von Irrland",
                      'https://upload.wikimedia.org/wikipedia/commons/2/2e/Iarnrod_Eireann_simple_logo_2013.png',
                      'Irishrail',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Instabil",
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTile(
                      "Österreichische Bundesbahnen (Teils Stabil)",
                      "Beinhaltet Daten der österreichischen Bundesbahn",
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
                      "Karlsruher Verkehrsbund (Experimentell)",
                      "Beinhaltet Daten des KVV Nahverkehrs",
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
                      "Verkehrsbund Rhein-Ruhr (Experimentell)",
                      "Beinhaltet Daten des VRR Nahverkehrs",
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
                      "Wiener Linien (Experimentell)",
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
                      "Schweizerische Bundesbahnen (Experimentell) ",
                      "Beinhaltet Daten der schweizerischen Bundesbahn",
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

  ListTile generateListTilePNG(String title, String subtitle, String imageURL, String ID, BuildContext context) {
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
        child: Center(child: Image.network(imageURL)),
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
