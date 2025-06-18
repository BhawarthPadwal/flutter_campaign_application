import 'package:campaign_application/themes/constants.dart';
import 'package:campaign_application/themes/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class kButtonTheme {
  kButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: kTextTheme.lightTextTheme.titleLarge?.copyWith(
            color: blackColor,
          ),
          backgroundColor: blackColor,
          foregroundColor: whiteColor,
          // text/icon color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(padding10),
          ),
          elevation: padding2,
          padding: const EdgeInsets.symmetric(
            vertical: padding14,
            horizontal: padding24,
          ),
        ),
      );

  static ElevatedButtonThemeData darkElevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: kTextTheme.darkTextTheme.titleLarge?.copyWith(
            color: whiteColor,
          ),
          backgroundColor: whiteColor,
          foregroundColor: blackColor,
          // text/icon color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(padding10),
          ),
          elevation: padding2,
          padding: const EdgeInsets.symmetric(
            vertical: padding14,
            horizontal: padding24,
          ),
        ),
      );
}
