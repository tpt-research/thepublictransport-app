import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:preferences/preferences.dart';
import 'package:thepublictransport_app/framework/language/LanguageBlocBase.dart';
import 'package:thepublictransport_app/pages/Home/Home.dart';
import 'package:thepublictransport_app/pages/Start/Start.dart';

import 'framework/language/GlobalTranslations.dart';
import 'framework/language/TranslationsBloc.dart';

void main() async {
  await allTranslations.init();

  // Preference Service Init
  await PrefService.init(prefix: 'pref_settings_');

  // Enable / Disable Crashlytics on start
  if (PrefService.getBool("crashlytics_mode") ?? false) {
    FlutterError.onError = Crashlytics.instance.recordFlutterError;
  }

  if (PrefService.getString('language') == null) {
    PrefService.setString('language', allTranslations.currentLanguage);
  }

  runApp(Boot());
}


class Boot extends StatefulWidget {
  @override
  _BootState createState() => _BootState();
}

class _BootState extends State<Boot> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FirebaseAnalytics _analytics = FirebaseAnalytics();
  TranslationsBloc translationsBloc;

  @override
  void initState() {
    // Set Firebase Analytics on start
    _analytics.setAnalyticsCollectionEnabled(PrefService.getBool("analytics_mode") ?? false);

    if (PrefService.getString('public_transport_data') == null) {
      PrefService.setString('public_transport_data', 'DB');
    }
    super.initState();
    translationsBloc = TranslationsBloc();
  }

  @override
  void dispose() {
    translationsBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LanguageBlocProvider<TranslationsBloc>(
      bloc: translationsBloc,
      child: StreamBuilder<Locale>(
          stream: translationsBloc.currentLocale,
          initialData: allTranslations.locale,
          builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {

            return MaterialApp(
              title: 'The Public Transport',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.grey,
                fontFamily: 'NunitoSans',
              ),
              home: getSplashRun(),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: _analytics),
              ],
              locale: snapshot.data ?? allTranslations.locale,
              supportedLocales: allTranslations.supportedLocales(),
            );
          }
      ),
    );
  }

  Widget getSplashRun() {
    if (PrefService.getBool("firstrun") == null ? true : false || PrefService.getBool("firstrun") == false) {
      return Start();
    } else {
      return Home();
    }
  }
}

