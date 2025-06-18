import 'package:campaign_application/themes/constants.dart';
import 'package:flutter/material.dart';

class kTextTheme {
  kTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    titleLarge: TextStyle().copyWith(fontSize: padding16, fontWeight: FontWeight.w600, color: blackColor, fontFamily: 'Inter'),
    titleMedium: TextStyle().copyWith(fontSize: padding16, fontWeight: FontWeight.w600, color: blackColor, fontFamily: 'Inter'),
    titleSmall: TextStyle().copyWith(fontSize: padding16, fontWeight: FontWeight.w600, color: blackColor, fontFamily: 'Inter'),

    bodyLarge: TextStyle().copyWith(fontSize: padding14, fontWeight: FontWeight.w400, color: blackColor, fontFamily: 'Inter'),
    bodyMedium: TextStyle().copyWith(fontSize: padding12, fontWeight: FontWeight.w400, color: blackColor, fontFamily: 'Inter'),
    bodySmall: TextStyle().copyWith(fontSize: padding10, fontWeight: FontWeight.w400, color: blackColor, fontFamily: 'Inter'),

    labelLarge: TextStyle().copyWith(fontSize: padding12, fontWeight: FontWeight.w500, color: blackColor, fontFamily: 'Inter'),
    labelMedium: TextStyle().copyWith(fontSize: padding10, fontWeight: FontWeight.w500, color: blackColor, fontFamily: 'Inter'),
    labelSmall: TextStyle().copyWith(fontSize: padding8, fontWeight: FontWeight.w500, color: blackColor, fontFamily: 'Inter'),
  );

  static TextTheme darkTextTheme = TextTheme(
    titleLarge: TextStyle().copyWith(fontSize: padding16, fontWeight: FontWeight.w600, color: whiteColor, fontFamily: 'Inter'),
    titleMedium: TextStyle().copyWith(fontSize: padding16, fontWeight: FontWeight.w600, color: whiteColor, fontFamily: 'Inter'),
    titleSmall: TextStyle().copyWith(fontSize: padding16, fontWeight: FontWeight.w600, color: whiteColor, fontFamily: 'Inter'),

    bodyLarge: TextStyle().copyWith(fontSize: padding14, fontWeight: FontWeight.w400, color: whiteColor, fontFamily: 'Inter'),
    bodyMedium: TextStyle().copyWith(fontSize: padding12, fontWeight: FontWeight.w400, color: whiteColor,fontFamily: 'Inter'),
    bodySmall: TextStyle().copyWith(fontSize: padding10, fontWeight: FontWeight.w400, color: whiteColor, fontFamily: 'Inter'),

    labelLarge: TextStyle().copyWith(fontSize: padding12, fontWeight: FontWeight.w500, color: whiteColor, fontFamily: 'Inter'),
    labelMedium: TextStyle().copyWith(fontSize: padding10, fontWeight: FontWeight.w500, color: whiteColor, fontFamily: 'Inter'),
    labelSmall: TextStyle().copyWith(fontSize: padding8, fontWeight: FontWeight.w500, color: whiteColor, fontFamily: 'Inter'),
  );
}
