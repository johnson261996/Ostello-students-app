import 'package:flutter/material.dart';

import './colours.dart';

const TextStyle kLargeBoldTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: kBlack,
  fontFamily: 'DM Sans',
);

const TextStyle kLargeTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: kGray,
  fontFamily: 'DM Sans',
);

const TextStyle kBodyTextStyle = TextStyle(
  fontSize: 21.0,
  fontWeight: FontWeight.w400,
  color: kGray,
  fontFamily: 'DM Sans',
);

const TextStyle kButtonPrimaryStyle = TextStyle(
  fontSize: 14.0,
  color: kPrimary,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

const TextStyle kButtonSecondaryStyle = TextStyle(
  fontSize: 14.0,
  color: kPureWhite,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);

ThemeData lightTheme = ThemeData(
  fontFamily: 'Mulish',
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      side: MaterialStateProperty.all(
        const BorderSide(color: kPrimary, width: 1.2),
      ),
    ),
  ),
  colorScheme: const ColorScheme(
    secondary: kPrimary,
    primary: kPrimary,
    error: Colors.red,
    background: kPureWhite,
    onSurface: kBodyTextColor,
    surface: kPrimary,
    onPrimary: kWhite,
    brightness: Brightness.light,
    onError: kWhite,
    onSecondary: kWhite,
    onBackground: kBodyTextColor,
  ),
  iconTheme: const IconThemeData(
    color: kPrimary,
    size: 24,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: kWhite,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      color: kTitleTextColor,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: kTitleTextColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      color: kTitleTextColor,
      fontFamily: "Roboto",
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: "Roboto",
      color: kBodyTextColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  ),
);
