import 'package:flutter/material.dart';

import '../themes/constants.dart';

void showSnackbar(
  BuildContext context, {
  required String message,
  Color? backgroundColor,
  Duration duration = const Duration(seconds: 2),
  SnackBarAction? action,
}) {
  final bgColor = backgroundColor ?? Theme.of(context).colorScheme.surface;

  ScaffoldMessenger.of(context).hideCurrentSnackBar(); // optional
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      backgroundColor: bgColor,
      duration: duration,
      action: action,
    ),
  );
}

// Sized box
SizedBox heightBox(double height) {
  return SizedBox(height: height);
}

SizedBox widthBox(double width) {
  return SizedBox(width: width);
}

// TextStyle

TextStyle kCustomTextStyle(Color color, double size, bool isBold) {
  return TextStyle(
    fontSize: size,
    fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
    fontFamily: 'Inter',
    color: color,
  );
}

TextStyle kTextStyleCustomSubText(
  Color color,
  double size,
  bool isBold, {
  bool? cairo,
}) {
  return TextStyle(
    color: color,
    fontWeight: isBold ? FontWeight.w600 : FontWeight.w300,
    fontSize: size,
    fontFamily: 'Montserrat',
  );
}

InputDecoration kInputDecoGradient(
  BuildContext context,
  String label,
  String hint,
) {
  final theme = Theme.of(context);

  return InputDecoration(
    labelText: label,
    hintText: hint,
    labelStyle: TextStyle(
      color: theme.textTheme.bodyLarge?.color, // Adaptive label color
    ),
    hintStyle: TextStyle(
      color: theme.hintColor, // Adaptive hint color
    ),
    prefixIcon: Icon(Icons.email, color: theme.iconTheme.color),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blueGrey, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    filled: true,
    fillColor:
        theme.inputDecorationTheme.fillColor ??
        (theme.brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.grey[100]),
    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
  );
}

InputDecoration kInputDecoGradientPassword(
  BuildContext context,
  String label,
  String hint,
  bool isHidden,
  VoidCallback toggleVisibility,
) {
  final theme = Theme.of(context);

  return InputDecoration(
    labelText: label,
    hintText: hint,
    labelStyle: TextStyle(color: theme.textTheme.bodyLarge?.color),
    hintStyle: TextStyle(color: theme.hintColor),
    prefixIcon: Icon(Icons.lock, color: theme.iconTheme.color),
    suffixIcon: IconButton(
      icon: Icon(
        isHidden ? Icons.visibility_off : Icons.visibility,
        color: theme.iconTheme.color,
      ),
      onPressed: toggleVisibility,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blueGrey, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    filled: true,
    fillColor:
        theme.inputDecorationTheme.fillColor ??
        (theme.brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.grey[100]),
    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
  );
}

/*InputDecoration kInputDecoGradient(BuildContext context, String label, String hint) {
  final iconColor = Theme.of(context).iconTheme.color;

  return InputDecoration(
    labelText: label,
    hintText: hint,
    labelStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
    hintStyle: TextStyle(color: Colors.grey[600]),
    prefixIcon: Icon(Icons.email, color: iconColor),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blueGrey, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    filled: true,
    fillColor: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey[100],
    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
  );
}

InputDecoration kInputDecoGradientPassword(
    BuildContext context,
    String label,
    String hint,
    bool isHidden,
    VoidCallback toggleVisibility,
    ) {
  final iconColor = Theme.of(context).iconTheme.color;

  return InputDecoration(
    labelText: label,
    hintText: hint,
    labelStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
    hintStyle: TextStyle(color: Colors.grey[600]),
    prefixIcon: Icon(Icons.lock, color: iconColor),
    suffixIcon: IconButton(
      icon: Icon(
        isHidden ? Icons.visibility_off : Icons.visibility,
        color: iconColor,
      ),
      onPressed: toggleVisibility,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: blueGreyColor, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    filled: true,
    fillColor: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey[100],
    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
  );
}*/

BoxDecoration kboxDecoration(double radius, Color borderColor, Color bgColor) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: borderColor),
    color: bgColor,
  );
}

TextField kCustomTextField(
  TextEditingController controller,
  String labelText,
  String inputType,
) {
  return TextField(
    keyboardType:
        inputType == 'number' ? TextInputType.number : TextInputType.text,
    controller: controller,
    decoration: InputDecoration(
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: blackColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: blackColor,
        ), // Set black border when enabled
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: blackColor,
          width: 2.0,
        ), // Set black border when focused
      ),
      labelText: labelText,
      labelStyle: kCustomTextStyle(blackColor, padding14, true),
    ),
  );
}
