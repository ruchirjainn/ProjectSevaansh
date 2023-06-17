import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.red,
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue,
        textStyle: const TextStyle(
          color: Colors.blue,
        ),
        side: const BorderSide(color: Colors.blue, width: 1.7),
        disabledForegroundColor: Colors.blue.withOpacity(0.38)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 48),
      backgroundColor: Colors.red,
      textStyle: const TextStyle(
        fontSize: 18.0,
      ),
      disabledBackgroundColor: Colors.grey,
    ),
  ),
  primarySwatch: Colors.blue,
  canvasColor: Colors.blue,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      toolbarTextStyle: TextStyle(color: Colors.black),
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black)),
);

OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
);
