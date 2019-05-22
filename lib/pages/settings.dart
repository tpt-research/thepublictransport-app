import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptfabscaffold.dart';
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
              values: ['Suche', 'In der Nähe', 'Pendlertools'],
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
            ),
            RadioPreference(
              'Dark Theme (coming soon)',
              'dark',
              'ui_theme',
            ),
            PreferenceTitle(
                'flux.fail'.toUpperCase(),
                leftPadding: 15,
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey
                )
            ),
            PreferenceDialogLink(
              'E-Mail ändern',
              dialog: PreferenceDialog(
                [
                  TextFieldPreference(
                    'E-Mail hier eingeben',
                    'change_mail',
                    padding: const EdgeInsets.only(top: 8.0),
                    autofocus: true,
                    maxLines: 1,
                  )
                ],
                title: 'E-Mail ändern',
                cancelText: 'Abbrechen',
                submitText: 'Sichern',
                onlySaveOnSubmit: true,
              ),
              onPop: () => setState(() {}),
            ),
            PreferenceText(
              "flux.fail E-Mail: " + PrefService.getString('change_mail') ?? "Keine angegeben",
              style: TextStyle(color: Colors.grey),
            ),
          ]),
      ),
    );
  }
}