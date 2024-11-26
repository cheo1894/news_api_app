import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themeprovider extends ChangeNotifier {
  bool _theme = false;

  bool get theme => _theme;

  Themeprovider() {
    _loadTheme();
  }

  saveTheme(bool value) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('theme', value);
    _theme = value;
    notifyListeners();
  }

  void _loadTheme() async {
    final _prefs = await SharedPreferences.getInstance();
    _theme = _prefs.getBool('theme') ?? false;
    notifyListeners();
  }
}
