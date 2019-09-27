import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:thepublictransport_app/backend/models/core/AlertModel.dart';
import 'package:thepublictransport_app/backend/service/alert/AlertService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Result/ResultDeeplink.dart';
import 'package:thepublictransport_app/ui/scaffold/FlareScaffoldBackground.dart';
import 'package:toast/toast.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import 'HomeBackground.dart';
import 'HomeCollapsed.dart';
import 'HomeSlider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var theme = ThemeEngine.getCurrentTheme();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: theme.backgroundColor, // navigation bar color
        statusBarColor: Colors.transparent, // status bar color
        statusBarBrightness: theme.statusbarBrightness,
        statusBarIconBrightness: theme.statusbarIconBrightness,
        systemNavigationBarIconBrightness: theme.navbarIconBrightness
    ));
    initUniLinks();
    fetchAlert();
    super.initState();
  }

  Future<Null> initUniLinks() async {
    try {
      if (await getInitialLink() != null) {
        Uri initialLink = await getInitialUri();
        Map<String, String> parsed = initialLink.queryParameters;

        if (initialLink.path != "/share")
          return;

        await Navigator.push(context, MaterialPageRoute(builder: (context) => ResultDeeplink(
          fromName: parsed['fromName'],
          fromID: parsed['fromID'],
          toName: parsed['toName'],
          toID: parsed['toID'],
          date: parsed['date'],
          time: parsed['time'],
          barrier: parsed['barrier'],
          slowwalk: parsed['slowwalk'],
          fastroute: parsed['fastroute'],
          source: parsed['source'],
        )));
      } else {
        // Do nothing
      }
    } on PlatformException {
      Toast.show("Das hat leider nicht geklappt :(", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
    }
  }

  Future<Null> fetchAlert() async {
    AlertModel alert = await AlertService.getAlert();

    if (PrefService.getBool('show_alert_dialog') == null)
      PrefService.setBool('show_alert_dialog', true);

    if (alert.message.messageId == 0) {
      PrefService.setBool('show_alert_dialog', true);
    } else {
      if (PrefService.getBool('show_alert_dialog')) {
        _showAlert(alert);
        PrefService.setBool('show_alert_dialog', false);
      }
    }
  }

  void _showAlert(AlertModel message) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0)
          ),
          backgroundColor: theme.backgroundColor,
          title: new Text("Alarm: " + message.message.translations.de.title, style: TextStyle(color: theme.textColor)),
          content: new Text(message.message.translations.de.message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Schließen", style: TextStyle(color: theme.textColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Mehr Infos", style: TextStyle(color: theme.textColor)),
              onPressed: () {
                getAlertPage(message.message.translations.de.link);
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(36.0),
      topRight: Radius.circular(36.0),
    );

    PanelController _pc = new PanelController();

    var theme = ThemeEngine.getCurrentTheme();

    
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SlidingUpPanel(
        // Config
        borderRadius: radius,
        minHeight: MediaQuery.of(context).size.height * 0.50,
        maxHeight: MediaQuery.of(context).size.height * 0.95,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        controller: _pc,

        // Main Widgets
        collapsed: Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              10,
              MediaQuery.of(context).size.width * 0.05,
              0
          ),
          child: HomeCollapsed(),
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: radius
          ),
        ),
        panel: Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              10,
              MediaQuery.of(context).size.width * 0.05,
              0
          ),
          child: HomeSlider(),
          decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: radius
          ),
        ),
        body: Stack(
          children: <Widget>[
            FlareScaffoldBackground(),
            Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    MediaQuery.of(context).size.height * 0.09,
                    MediaQuery.of(context).size.width * 0.05,
                    0
                ),
                child: HomeBackground(_pc)
            ),
          ],
        ),
      ),
    );
  }

  getAlertPage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}




