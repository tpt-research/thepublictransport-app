import 'package:preferences/preference_service.dart';

import 'model/Theme.dart';

class ThemeEngine {

  static Theme getCurrentTheme() {
    return PrefService.getBool("theme_mode") == true ? Theme.darkTheme() : Theme.lightTheme();
  }
}