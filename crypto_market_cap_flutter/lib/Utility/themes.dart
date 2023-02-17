
import 'package:flutter/material.dart';

class Themes {
  static final brightTheme = ThemeData(
    splashColor: Colors.white,
    primaryColor: CustomColors.backgroundGrey,
    scaffoldBackgroundColor: CustomColors.backgroundGrey,
    //colorScheme: ColorScheme.fromSeed(seedColor: CustomColors.backgroundGrey) 
  );
  
}

class CustomColors {
  static const backgroundGrey = Color(0xffaaadab);
}