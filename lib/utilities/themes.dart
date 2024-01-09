import 'package:flutter/material.dart';

import 'constants.dart';

class AppTheme {
  static final def = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        vertical: kDefaultPadding * 0.8,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        borderSide: BorderSide(
          color: kGrey,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: 2.0,
        ),
      ),
      labelStyle: TextStyle(color: kGrey),
      errorStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
      errorMaxLines: 3,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
    ),
    useMaterial3: true,
  );
}
