import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/pages/misc/firstrun.dart';
import 'package:thepublictransport_app/ui/base/tptsettingsscaffold.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class SettingsWidget extends StatefulWidget {
  @override
  SettingsWidgetState createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  Widget build(BuildContext context) {
    return TPTScaffold(
      title: "Einstellungen",
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 200,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Card(
          elevation: 5,
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.0),
              side: ColorThemeEngine.decideBorderSide()),
          child: PreferencePage([
            PreferenceTitle('General'.toUpperCase(),
                leftPadding: 15,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey)),
            DropdownPreference(
              'Startseite',
              'start_page',
              defaultVal: 'Suche',
              values: ['Suche', 'In der Nähe'],
            ),
            PreferenceTitle('Design'.toUpperCase(),
                leftPadding: 15,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey)),
            RadioPreference(
              'Light Theme',
              'light',
              'ui_theme',
              isDefault: true,
              onSelect: () async {
                if (PrefService.getBool("settingsfirstrun") == null) {
                  // Do nothing
                } else {
                  await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text(
                              'Sie müssen die App neustarten, damit das Design sich verändert'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                SystemChannels.platform
                                    .invokeMethod('SystemNavigator.pop');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                }
              },
            ),
            RadioPreference(
              'Dark Theme',
              'dark',
              'ui_theme',
              onSelect: () async {
                await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text(
                            'Sie müssen die App neustarten, damit das Design sich verändert'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              },
            ),
            PreferenceTitle('Akzentfarben'.toUpperCase(),
                leftPadding: 15,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey)),
            RadioPreference(
              'Default',
              'default',
              'accent_theme',
              isDefault: true,
              onSelect: () async {
                if (PrefService.getBool("settingsfirstrun") == null) {
                  // Do nothing
                } else {
                  await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text(
                              'Sie müssen die App neustarten, damit das Design sich verändert'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                SystemChannels.platform
                                    .invokeMethod('SystemNavigator.pop');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                }
              },
            ),
            RadioPreference(
              'Falcon',
              'falcon',
              'accent_theme',
              onSelect: () async {
                await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text(
                            'Sie müssen die App neustarten, damit das Design sich verändert'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              },
            ),
            RadioPreference(
              'Charme',
              'charme',
              'accent_theme',
              onSelect: () async {
                await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text(
                            'Sie müssen die App neustarten, damit das Design sich verändert'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              },
            ),
            RadioPreference(
              'Sun',
              'sun',
              'accent_theme',
              onSelect: () async {
                await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text(
                            'Sie müssen die App neustarten, damit das Design sich verändert'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              },
            ),
            RadioPreference(
              'Pride',
              'pride',
              'accent_theme',
              onSelect: () async {
                await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text(
                            'Sie müssen die App neustarten, damit das Design sich verändert'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    });
              },
            ),
            PreferenceTitle('Vorschau'.toUpperCase(),
                leftPadding: 15,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey)),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FirstrunPage()));
              },
              child: PreferenceText(
                'Vorschau anzeigen',
              ),
            )
          ]),
        ),
      ),
    );
  }
}
