import 'dart:convert';

import 'package:mvvmbasic/utils/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocal {
  late SharedPreferences _prefs;

  //SharedPreferencesLocal instance = SharedPreferencesLocal();

  Future<SharedPreferencesLocal> init() async {
    // Obtain shared preferences.
    _prefs = await SharedPreferences.getInstance();

    return this;
  }

  void setString(PrefKeys prefKeys, String value) {
    _prefs.setString(prefKeys.name, value);
  }

  void setInt(PrefKeys prefKeys, int value) {
    _prefs.setInt(prefKeys.name, value);
  }

  void setDouble(PrefKeys prefKeys, double value) {
    _prefs.setDouble(prefKeys.name, value);
  }

  void setBool(PrefKeys prefKeys, bool value) {
    _prefs.setBool(prefKeys.name, value);
  }

  void setSet(PrefKeys prefKeys, List<String> value) {
    _prefs.setStringList(prefKeys.name, value);
  }

  void setMap(PrefKeys prefKeys, Map<String, dynamic> value) {
    _prefs.setString(prefKeys.name, jsonEncode(value));
  }

  String getString(PrefKeys prefKeys, {String defaultValue = ""}) {
    return _prefs.getString(prefKeys.name) ?? defaultValue;
  }

  int getInt(PrefKeys prefKeys, {int defaultValue = 0}) {
    return _prefs.getInt(prefKeys.name) ?? defaultValue;
  }

  double getDouble(PrefKeys prefKeys, {double defaultValue = 0.1}) {
    return _prefs.getDouble(prefKeys.name) ?? defaultValue;
  }

  bool getBool(PrefKeys prefKeys, {bool defaultValue = false}) {
    return _prefs.getBool(prefKeys.name) ?? defaultValue;
  }

  List<String> getSet(PrefKeys prefKeys) {
    return _prefs.getStringList(prefKeys.name) ?? [] as List<String>;
  }

  Map<dynamic, dynamic> getMap(PrefKeys prefKeys) {
    return jsonDecode(
      _prefs.getString(prefKeys.name) ?? "{}",
    );
  }

  void clearPref() {
    _prefs.clear();
  }
}
