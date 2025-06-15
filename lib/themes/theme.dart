import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFffffff);
const Color whiteColor = Colors.white;
const Color blueGreyColor = Colors.blueGrey;
const Color blackColor = Colors.black;
Color textFieldBgColor = const Color(0xffffffff).withOpacity(0.155);

const double padding5 = 5.0;
const double padding10 = 10.0;
const double padding14 = 14.0;
const double padding15 = 15.0;
const double padding18 = 18.0;
const double padding20 = 20.0;
const double padding25 = 25.0;
const double padding30 = 30.0;
const double padding40 = 40.0;
const double padding50 = 50.0;
const double padding60 = 60.0;
const double padding70 = 70.0;
const double padding80 = 80.0;
const double padding90 = 90.0;

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
    fontFamily: 'Montserrat',
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

InputDecoration kInputDecoGradient(String label, String hint) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    labelStyle: TextStyle(color: Colors.grey[800]),
    // darker label
    hintStyle: TextStyle(color: Colors.grey[600]),
    prefixIcon: Icon(Icons.email, color: Colors.blueGrey),
    // Better visibility
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    filled: true,
    fillColor: Colors.grey[100],
    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
  );
}

InputDecoration kInputDecoGradientPassword(
  String label,
  String hint,
  bool isHidden,
  VoidCallback toggleVisibility,
) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    labelStyle: TextStyle(color: Colors.grey[800]),
    hintStyle: TextStyle(color: Colors.grey[600]),
    prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
    suffixIcon: IconButton(
      icon: Icon(
        isHidden ? Icons.visibility_off : Icons.visibility,
        color: Colors.blueGrey,
      ),
      onPressed: toggleVisibility,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    filled: true,
    fillColor: Colors.grey[100],
    contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
  );
}

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
