import 'package:alarm_app/constants.dart';
import 'package:flutter/material.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kLightThemeColor,
    canvasColor: Colors.transparent,
    colorScheme: ColorScheme.light(
      primary: kPrimaryColor,
      primaryVariant: kLineLightClock,
      secondary: kSecondaryColor,
      error: kErrorColor,
      surface: kLineDarkClock,
      onSurface: Colors.black,
      onPrimary: Colors.white,
    ),
    accentColor: kSecondaryColor,
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kDarkThemeColor,
    canvasColor: Colors.transparent,
    colorScheme: ColorScheme.dark(
      primary: kPrimaryColor,
      primaryVariant: kLineDarkClock,
      secondary: kSecondaryColor,
      error: kErrorColor,
      surface: kLineDarkClock,
      onSurface: Colors.white,
      onPrimary: Colors.black,
    ),
    accentColor: kWarningColor,
  );
}
