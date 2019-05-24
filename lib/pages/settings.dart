import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thepublictransport_app/ui/base/tptfabnothemescaffold.dart';
import 'package:preferences/preferences.dart';

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
          child: PreferencePage([
            PreferenceTitle(
                'General'.toUpperCase(),
                leftPadding: 15,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey
                )
            ),
            DropdownPreference(
              'Startseite',
              'start_page',
              defaultVal: 'Suche',
              values: ['Suche', 'In der Nähe'],
            ),
            PreferenceTitle(
                'Personalisierung'.toUpperCase(),
                leftPadding: 15,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey
                )
            ),
            RadioPreference(
              'Light Theme',
              'light',
              'ui_theme',
              isDefault: true,
              onSelect: () async {
                await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text('Sie müssen die App neustarten, damit das Design sich verändert'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () { SystemChannels.platform.invokeMethod('SystemNavigator.pop'); },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }
                );
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
                        title: const Text('Sie müssen die App neustarten, damit das Design sich verändert'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () { SystemChannels.platform.invokeMethod('SystemNavigator.pop'); },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }
                );
              },
            )
          ]),
      ),
    );
  }
}