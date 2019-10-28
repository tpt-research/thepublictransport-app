import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/About/About.dart';
import 'package:thepublictransport_app/pages/Start/Start.dart';
import 'package:thepublictransport_app/ui/components/OptionSwitch.dart';

class Settings extends StatefulWidget {

  final PageController pageController;
  final GlobalKey<CurvedNavigationBarState> curvedKey;

  const Settings({Key key, this.pageController, this.curvedKey}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState(pageController, curvedKey);
}

class _SettingsState extends State<Settings> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(36.0),
    topRight: Radius.circular(36.0),
  );

  var theme = ThemeEngine.getCurrentTheme();

  final PageController pageController;
  final GlobalKey<CurvedNavigationBarState> curvedKey;

  _SettingsState(this.pageController, this.curvedKey);

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
                allTranslations.text('SETTINGS.TITLE'),
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
                        title: allTranslations.text('SETTINGS.DATA_SAVE.TITLE'),
                        subtitle: allTranslations.text('SETTINGS.DATA_SAVE.DESCRIPTION'),
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
                        title: allTranslations.text('SETTINGS.DARK_THEME.TITLE'),
                        subtitle: allTranslations.text('SETTINGS.DARK_THEME.DESCRIPTION'),
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
                        title: allTranslations.text('SETTINGS.ANALYTICS.TITLE'),
                        subtitle: allTranslations.text('SETTINGS.ANALYTICS.DESCRIPTION'),
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
                        title: allTranslations.text('SETTINGS.CRASHLYTICS.TITLE'),
                        subtitle: allTranslations.text('SETTINGS.CRASHLYTICS.DESCRIPTION'),
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
                      new OptionSwitch(
                        title: allTranslations.text('SETTINGS.SCOOTER.TITLE'),
                        subtitle: allTranslations.text('SETTINGS.SCOOTER.DESCRIPTION'),
                        icon: MaterialCommunityIcons.bike,
                        id: "scooter_mode",
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
                        leading: new Icon(Icons.language, color: theme.iconColor),
                        title: new Text(
                          allTranslations.text('SETTINGS.LANGUAGE.TITLE'),
                          style: TextStyle(
                              color: theme.titleColor,
                              fontFamily: "NunitoSansBold"
                          ),
                        ),
                        subtitle: Text(
                          allTranslations.text('SETTINGS.LANGUAGE.DESCRIPTION'),
                          style: TextStyle(
                              color: theme.subtitleColor
                          ),
                        ),
                        onTap: () async {
                          await showLanguageDialog();
                          curvedKey.currentState.setPage(0);
                          pageController.animateToPage(0,
                              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
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
                        leading: new Icon(Icons.directions_bus, color: theme.iconColor),
                        title: new Text(
                          allTranslations.text('SETTINGS.DATA_CHANGE.TITLE'),
                          style: TextStyle(
                              color: theme.titleColor,
                              fontFamily: "NunitoSansBold"
                          ),
                        ),
                        subtitle: Text(
                          allTranslations.text('SETTINGS.DATA_CHANGE.DESCRIPTION'),
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
                          allTranslations.text('SETTINGS.PREVIEW.TITLE'),
                          style: TextStyle(
                              color: theme.titleColor,
                              fontFamily: "NunitoSansBold"
                          ),
                        ),
                        subtitle: Text(
                          allTranslations.text('SETTINGS.PREVIEW.DESCRIPTION'),
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
                          allTranslations.text('SETTINGS.ABOUT.TITLE'),
                          style: TextStyle(
                              color: theme.titleColor,
                              fontFamily: "NunitoSansBold"
                          ),
                        ),
                        subtitle: Text(
                            allTranslations.text('SETTINGS.ABOUT.DESCRIPTION'),
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
                    allTranslations.text('SETTINGS.COUNTRY.GERMANY'),
                    style: TextStyle(
                      fontFamily: 'NunitoSansBold',
                      color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTile(
                      "Deutsche Bahn / DB Navigator",
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
                      'https://upload.wikimedia.org/wikipedia/de/0/09/Ingolst%C3%A4dter_Verkehrsgesellschaft_Logo.svg',
                      'INVG',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    allTranslations.text('SETTINGS.COUNTRY.SWITZERLAND'),
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
                      'https://upload.wikimedia.org/wikipedia/commons/2/2b/Logo_ZVV.svg',
                      'ZVV',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    allTranslations.text('SETTINGS.COUNTRY.LUXEMBOURG'),
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
                      'https://www.mobiliteit.lu/wp-content/themes/mobiliteit/assets/img/mobiliteit-logo.svg',
                      'LU',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    allTranslations.text('SETTINGS.COUNTRY.BELGIUM'),
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
                      'https://upload.wikimedia.org/wikipedia/commons/9/9d/LogoBR.svg',
                      'SNCB',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    allTranslations.text('SETTINGS.COUNTRY.DENMARK'),
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
                      'https://upload.wikimedia.org/wikipedia/commons/a/a3/Danske_Statsbaner_logo2014.png',
                      'DSB',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    allTranslations.text('SETTINGS.COUNTRY.AUSTRIA'),
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTilePNG(
                      "VOR AnachB",
                      'https://anachb.vor.at/hafas-res/img/vs_voranachb/logo_voranachb_small_new.png',
                      'AnachB',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    allTranslations.text('SETTINGS.COUNTRY.GRAT_BRITAIN'),
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
                      'https://upload.wikimedia.org/wikipedia/commons/3/3f/New_Logo_Arriva.png',
                      'ArrivaUK',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    allTranslations.text('SETTINGS.COUNTRY.USA_CALIFORNIA'),
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTile(
                      "Bay Area Rapid Transit",
                      'https://upload.wikimedia.org/wikipedia/commons/2/26/Bart-logo.svg',
                      'BART',
                      context
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    allTranslations.text('SETTINGS.COUNTRY.IRELAND'),
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateListTilePNG(
                      "Iarnród Éireann",
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
                      'https://upload.wikimedia.org/wikipedia/commons/0/00/Sbb-logo.svg',
                      'SBB',
                      context
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(allTranslations.text('GENERAL.CLOSE'), style: TextStyle(color: theme.textColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  void showLanguageDialog() async {
    await showDialog(
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
                    allTranslations.text('SETTINGS.LANGUAGE.TITLE'),
                    style: TextStyle(
                        fontFamily: 'NunitoSansBold',
                        color: Colors.grey
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  generateLanguageTile(
                      "English",
                      'https://upload.wikimedia.org/wikipedia/commons/a/ae/Flag_of_the_United_Kingdom.svg',
                      'en',
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
                  generateLanguageTilePNG(
                      "Deutsch",
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Germany.svg/800px-Flag_of_Germany.svg.png',
                      'de',
                      context
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(allTranslations.text('GENERAL.CLOSE'), style: TextStyle(color: theme.textColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  ListTile generateLanguageTile(String title, String imageURL, String ID, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: theme.titleColor,
            fontFamily: "NunitoSansBold"
        ),
      ),
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Center(child: SvgPicture.network(imageURL)),
      ),
      trailing: Icon(
          PrefService.getString('language') == ID ? Icons.radio_button_checked : Icons.radio_button_unchecked
      ),
      onTap: () async {
        PrefService.setString('language', ID);
        await allTranslations.setNewLanguage(ID);
        await Navigator.of(context).pop();
      },
    );
  }

  ListTile generateLanguageTilePNG(String title, String imageURL, String ID, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: theme.titleColor,
            fontFamily: "NunitoSansBold"
        ),
      ),
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Center(child: Image.network(imageURL)),
      ),
      trailing: Icon(
          PrefService.getString('language') == ID ? Icons.radio_button_checked : Icons.radio_button_unchecked
      ),
      onTap: () async {
        PrefService.setString('language', ID);
        await allTranslations.setNewLanguage(ID);
        await Navigator.of(context).pop();
      },
    );
  }

  ListTile generateListTile(String title, String imageURL, String ID, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: theme.titleColor,
            fontFamily: "NunitoSansBold"
        ),
      ),
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

  ListTile generateListTilePNG(String title, String imageURL, String ID, BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: theme.titleColor,
            fontFamily: "NunitoSansBold"
        ),
      ),
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
