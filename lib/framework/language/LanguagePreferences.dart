import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const String _storageKey = "Appli_";

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

LanguagePreferences preferences = LanguagePreferences();

class LanguagePreferences {
  /// ----------------------------------------------------------
  /// Generic routine to fetch a preference
  /// ----------------------------------------------------------
  Future<String> _getApplicationSavedInformation(String name) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString(_storageKey + name) ?? '';
  }

  /// ----------------------------------------------------------
  /// Generic routine to saves a preference
  /// ----------------------------------------------------------
  Future<bool> _setApplicationSavedInformation(String name, String value) async {
    final SharedPreferences prefs = await _prefs;

    return prefs.setString(_storageKey + name, value);
  }

  /// ----------------------------------------------------------
  /// Method that saves/restores the preferred language
  /// ----------------------------------------------------------
  getPreferredLanguage() async {
    return _getApplicationSavedInformation('language');
  }
  setPreferredLanguage(String lang) async {
    return _setApplicationSavedInformation('language', lang);
  }

  // ------------------ SINGLETON -----------------------
  static final LanguagePreferences _preferences = LanguagePreferences._internal();
  factory LanguagePreferences(){
    return _preferences;
  }
  LanguagePreferences._internal();
}