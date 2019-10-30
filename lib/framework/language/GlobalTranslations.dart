import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';

import 'LanguagePreferences.dart';

const List<String> _kSupportedLanguages = ["de", "en", "es"];
const String _kDefaultLanguage = "en";

class GlobalTranslations {
  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;
  Map<String, String> _cache = {};

  ///
  /// Returns the list of supported locales
  ///
  Iterable<Locale> supportedLocales() => _kSupportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  ///
  /// Return the translation that corresponds to the [key]
  ///
  /// The [key] might be a sequence of [key].[sub-key].[sub-key]
  ///
  String text(String key) {
    // Return the requested string
    String string = '** $key not found';

    if (_localizedValues != null) {
      // Check if the requested [key] is in the cache
      if (_cache[key] != null){
        return _cache[key];
      }

      // Iterate the key until found or not
      bool found = true;
      Map<dynamic, dynamic> _values = _localizedValues;
      List<String> _keyParts = key.split('.');
      int _keyPartsLen = _keyParts.length;
      int index = 0;
      int lastIndex = _keyPartsLen - 1;

      while(index < _keyPartsLen && found){
        var value = _values[_keyParts[index]];

        if (value == null) {
          // Not found => STOP
          found = false;
          break;
        }

        // Check if we found the requested key
        if (value is String && index == lastIndex){
          string = value;

          // Add to cache
          _cache[key] = string;
          break;
        }

        // go to next subKey
        _values = value;
        index++;
      }
    }
    return string;
  }

  String get currentLanguage => _locale == null ? '' : _locale.languageCode;
  Locale get locale => _locale;

  ///
  /// One-time initialization
  ///
  Future<Null> init() async {
    if (_locale == null){
      await setNewLanguage();
    }
    return null;
  }

  ///
  /// Routine to change the language
  ///
  Future<Null> setNewLanguage([String newLanguage]) async {
    String language = newLanguage;
    if (language == null){
      language = await preferences.getPreferredLanguage();
    }

    // If not in the preferences, get the current locale (as defined at the device settings level)
    if (language == ''){
      String currentLocale = Platform.localeName.toLowerCase();
      if (currentLocale.length > 2){
        if (currentLocale[2] == "-" || currentLocale[2] == "_"){
          language = currentLocale.substring(0, 2);
        }
      }
    }

    // Check if we are supporting the language
    // if not consider the default one
    if (!_kSupportedLanguages.contains(language)){
      language = _kDefaultLanguage;
    }

    // Set the Locale
    _locale = Locale(language, "");

    // Load the language strings
    String jsonContent = await rootBundle.loadString("locale/i18n_${_locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);

    // Clear the cache
    _cache = {};

    return null;
  }

  /// ==========================================================
  /// Singleton Factory
  ///
  static final GlobalTranslations _translations = GlobalTranslations._internal();
  factory GlobalTranslations() {
    return _translations;
  }
  GlobalTranslations._internal();
}

GlobalTranslations allTranslations = GlobalTranslations();