import 'package:flutter/material.dart';
import 'app_constants.dart';

TextStyle textStyleColorBoldSize(Color color, double size) {
  return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      fontFamily: AppConstants.fontFamily,
      color: color,
      decoration: TextDecoration.none
  );
}

TextStyle textStyleColorNormalSize(Color color, double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    fontFamily: AppConstants.fontFamily,
    color: color,
    decoration: TextDecoration.none,
  );
}

TextStyle textStyleLineThrough(Color color, double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.normal,
    fontFamily: AppConstants.fontFamily,
    color: color,
    decoration: TextDecoration.lineThrough,
  );
}