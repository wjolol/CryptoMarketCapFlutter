
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Themes extends ChangeNotifier {

  final String key = "theme";
  SharedPreferences? _prefs;
  late bool _darktheme;

  bool get darkTheme => _darktheme;


  Themes() {
    _darktheme = false;
    _loadprefs();
  }

  void switchTheme() {
      _darktheme = !_darktheme;
      _saveprefs();
      notifyListeners();
  }

  Future<void> _initiateprefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> _loadprefs() async {
    await _initiateprefs();
    _darktheme = _prefs?.getBool(key) ?? false;
    notifyListeners();
  }

  Future<void> _saveprefs() async {
    await _initiateprefs();
    _prefs?.setBool(key, _darktheme);
  }


  final brightThemeData = ThemeData(
    splashColor: Colors.white,
    primaryColor: Colors.white,
    cardColor: Colors.black,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.black, fontSize: 20),
      displayMedium: TextStyle(color: Colors.black, fontSize: 15),
      displaySmall: TextStyle(color: Colors.black, fontSize: 10),
      titleMedium: TextStyle(color: Colors.black, fontSize: 25),
      titleLarge: TextStyle(color: Colors.black, fontSize: 30),
      titleSmall: TextStyle(color: Colors.black, fontSize: 15),
      bodyLarge: TextStyle(color: Colors.black, fontSize: 20),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 15),
      bodySmall: TextStyle(color: Colors.black, fontSize: 10),
      
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => CustomColors.clear), elevation: MaterialStateProperty.resolveWith((states) => 0.0),))
    //scaffoldBackgroundColor: CustomColors.backgroundGrey,
  );

  final darkThemeData = ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.white, fontSize: 20),
      displayMedium: TextStyle(color: Colors.white, fontSize: 15),
      displaySmall: TextStyle(color: Colors.white, fontSize: 10),
      titleMedium: TextStyle(color: Colors.white, fontSize: 25),
      titleLarge: TextStyle(color: Colors.white, fontSize: 30),
      titleSmall: TextStyle(color: Colors.white, fontSize: 15),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 15),
      bodySmall: TextStyle(color: Colors.white, fontSize: 10),
      
    ),
    splashColor: Colors.black,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    cardColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => CustomColors.clear), elevation: MaterialStateProperty.resolveWith((states) => 0.0),))
  );
  
}

class CustomColors {
  static const backgroundGrey = Color(0xffaaadab);
  static const clear = Color.fromARGB(0, 255, 255, 255);
}