import 'package:campaign_application/themes/constants.dart';
import 'package:flutter/material.dart';

class kCardTheme {
  kCardTheme._();

  static CardTheme lightCardTheme = CardTheme(
    color: Color(0xFFF9FAFB),
    // Card background
    shadowColor: Colors.grey.withOpacity(0.3),
    // Subtle shadow
    surfaceTintColor: Colors.white,
    // Prevents unexpected color blending in Material3
    elevation: padding5,
    margin: const EdgeInsets.symmetric(
      vertical: padding8,
      horizontal: padding12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(padding16),
    ),
  );

  static CardTheme darkCardTheme = CardTheme(
    color: const Color(0xFF2A2A2A),
    // Dark background for cards
    shadowColor: Colors.black.withOpacity(0.6),
    // Deeper shadow for dark mode
    surfaceTintColor: Colors.transparent,
    // Prevents M3 tint from brightening it
    elevation: padding5,
    margin: const EdgeInsets.symmetric(
      vertical: padding8,
      horizontal: padding12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(padding16),
    ),
  );
}
