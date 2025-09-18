import 'package:flutter/material.dart';

class AppTextStyles {
  static double _scale(BuildContext context) =>
      MediaQuery.of(context).size.width / 375; // 375 = iPhone X width

  static TextStyle headingBlack(BuildContext context) => TextStyle(
    fontSize: 42 * _scale(context),
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle headingBlue(BuildContext context) => TextStyle(
    fontSize: 42 * _scale(context),
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  );

  static TextStyle subtitle(BuildContext context) =>
      TextStyle(fontSize: 16 * _scale(context), color: Colors.black54);

  static TextStyle category(BuildContext context) => TextStyle(
    fontSize: 12 * _scale(context),
    color: Colors.grey[600],
    fontWeight: FontWeight.w500,
  );

  static TextStyle headline(BuildContext context) => TextStyle(
    fontSize: 15 * _scale(context),
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    height: 1.3,
  );

  static TextStyle source(BuildContext context) => TextStyle(
    fontSize: 12 * _scale(context),
    color: Colors.grey[600],
    fontWeight: FontWeight.w500,
  );

  static TextStyle time(BuildContext context) =>
      TextStyle(fontSize: 12 * _scale(context), color: Colors.grey[500]);
}
