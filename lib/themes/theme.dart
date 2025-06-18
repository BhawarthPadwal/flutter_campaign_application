import 'package:campaign_application/themes/constants.dart';
import 'package:flutter/material.dart';

import 'custom_themes/button_theme.dart';
import 'custom_themes/card_theme.dart';
import 'custom_themes/text_theme.dart';

class kAppTheme {

  kAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: blueGreyColor,
      brightness: Brightness.light,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: whiteColor,
    textTheme: kTextTheme.lightTextTheme,
    cardTheme: kCardTheme.lightCardTheme,
    elevatedButtonTheme: kButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: blueGreyColor,
      brightness: Brightness.dark,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: blackColor,
    textTheme: kTextTheme.darkTextTheme,
    cardTheme: kCardTheme.darkCardTheme,
    elevatedButtonTheme: kButtonTheme.darkElevatedButtonTheme,
  );


}