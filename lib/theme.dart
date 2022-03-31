import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

class LanguageLearningTheme {
  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(
        fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.black),
    headline2: GoogleFonts.poppins(
        fontSize: 25.0, fontWeight: FontWeight.w500, color: Colors.black),
    headline3: GoogleFonts.poppins(
        fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.black),
    headline4: GoogleFonts.poppins(
        fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyText1: GoogleFonts.poppins(fontSize: 15.0, fontWeight: FontWeight.w400),
  );

  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(
        fontSize: 35.0, fontWeight: FontWeight.w400, color: Colors.white),
    headline2: GoogleFonts.poppins(
        fontSize: 25.0, fontWeight: FontWeight.w500, color: Colors.white),
    headline3: GoogleFonts.poppins(
        fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.white),
    headline4: GoogleFonts.poppins(
        fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.white),
    headline5: GoogleFonts.poppins(
        fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyText1: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyText2: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.grey),
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: darkTextTheme,
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: darkTextTheme.headline3,
        toolbarTextStyle: darkTextTheme.headline3,
        backgroundColor: Colors.deepPurple,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          textStyle: darkTextTheme.headline5,
          padding: const EdgeInsets.all(20.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: darkTextTheme.bodyText1,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusColor: Colors.white,
        hoverColor: Colors.deepPurple,
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelStyle: darkTextTheme.headline5,
        labelStyle: darkTextTheme.headline5,
      ),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: darkTextTheme.bodyText1,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor:
            MaterialStateProperty.resolveWith((states) => Colors.deepPurple),
      ),
      radioTheme: RadioThemeData(
        fillColor:
            MaterialStateProperty.resolveWith((states) => Colors.deepPurple),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple, focusColor: Colors.grey),
    );
  }
}
