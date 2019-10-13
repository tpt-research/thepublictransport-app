import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preference_service.dart';
import 'package:thepublictransport_app/backend/models/core/AlertModel.dart';
import 'package:thepublictransport_app/backend/service/alert/AlertService.dart';
import 'package:thepublictransport_app/backend/service/shortener/ShortenerService.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Home/HomeNearby.dart';
import 'package:thepublictransport_app/pages/Result/ResultDeeplink.dart';
import 'package:thepublictransport_app/pages/Search/SearchTrip.dart';
import 'package:thepublictransport_app/pages/Settings/Settings.dart';
import 'package:toast/toast.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var theme = ThemeEngine.getCurrentTheme();
  int currentPage = 0;
  PageController _pageController = new PageController();
  GlobalKey<FancyBottomNavigationState> bottombarKey = GlobalKey<FancyBottomNavigationState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: theme.backgroundColor, // navigation bar color
        statusBarColor: Colors.transparent, // status bar color
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: theme.navbarIconBrightness
    ));
    initUniLinks();
    fetchAlert();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: FancyBottomNavigation(
        key: bottombarKey,
        barBackgroundColor: theme.cardColor,
        textColor: theme.textColor,
        activeIconColor: theme.titleColorInverted,
        inactiveIconColor: Colors.grey,
        circleColor: theme.iconColor,
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.search, title: "Suche"),
          TabData(iconData: Icons.settings, title: "Einstellungen")
        ],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
            _pageController.animateToPage(position,
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          });
        },
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        children: <Widget>[
          HomeNearby(),
          SearchTrip(),
          Settings()
        ],
      ),
    );
  }

  Future<Null> initUniLinks() async {
    try {
      if (await getInitialLink() != null) {
        Uri initialLink = await ShortenerService.getLink(await getInitialLink());
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

    if (PrefService.getInt('show_alert_dialog_id') == null)
      PrefService.setInt('show_alert_dialog_id', 0);

    if (PrefService.getInt('show_alert_dialog_id') != alert.message.messageId && alert.message.messageId != 0) {
      _showAlert(alert);
      PrefService.setInt('show_alert_dialog_id', alert.message.messageId);
    }

    if (alert.message.messageId == 0) {
      PrefService.setInt('show_alert_dialog_id', 0);
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
          title: new Text(message.message.translations.de.title, style: TextStyle(color: theme.textColor, fontFamily: 'NunitoSansBold')),
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

  getAlertPage(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

