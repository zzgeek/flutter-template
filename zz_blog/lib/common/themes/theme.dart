import 'package:flutter/material.dart';

class Themes {
  static final green = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.green,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.green, toolbarTextStyle: TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 30)).bodyText2, titleTextStyle: TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 30)).headline6),
  );

  static final yellow = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.yellow,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.yellow, toolbarTextStyle: TextTheme(
              headline6: TextStyle(color: Colors.white, fontSize: 30)).bodyText2, titleTextStyle: TextTheme(
              headline6: TextStyle(color: Colors.white, fontSize: 30)).headline6),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepOrange))));

  static final red = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.red,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.red, toolbarTextStyle: TextTheme(
              headline6: TextStyle(color: Colors.white, fontSize: 30)).bodyText2, titleTextStyle: TextTheme(
              headline6: TextStyle(color: Colors.white, fontSize: 30)).headline6),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.brown))));

  static final black = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, toolbarTextStyle: TextTheme(
              headline6: TextStyle(color: Colors.white, fontSize: 30)).bodyText2, titleTextStyle: TextTheme(
              headline6: TextStyle(color: Colors.white, fontSize: 30)).headline6),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.brown))));

  static final white = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Color.fromRGBO(45, 58, 75, 1),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
  );
}