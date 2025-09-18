import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle headingBlack(BuildContext context) {
    double scale =
        MediaQuery.of(context).size.width / 375; // 375 = iPhone X width
    return TextStyle(
      fontSize: 42 * scale,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  static TextStyle headingBlue(BuildContext context) {
    double scale = MediaQuery.of(context).size.width / 375;
    return TextStyle(
      fontSize: 42 * scale,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    );
  }

  static TextStyle subtitle(BuildContext context) {
    double scale = MediaQuery.of(context).size.width / 375;
    return TextStyle(fontSize: 16 * scale, color: Colors.black54);
  }
}
