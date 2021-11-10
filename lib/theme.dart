import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialTheme {
  static TextTheme lightText = TextTheme(
    /// body1    16.0  regular  0.5   (bodyText1)
    bodyText1: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.black,
    ),

    /// body2   14.0  regular  0.25  (bodyText2)
    bodyText2: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black,
    ),

    /// headline1    96.0  light   -1.5
    headline1: GoogleFonts.openSans(
      fontSize: 96.0,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Colors.black,
    ),

    /// headline2    60.0  light   -0.5
    headline2: GoogleFonts.openSans(
      fontSize: 60.0,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.black,
    ),

    /// headline3    48.0  regular  0.0
    headline3: GoogleFonts.openSans(
      fontSize: 48.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: Colors.black,
    ),

    /// headline4    34.0  regular  0.25
    headline4: GoogleFonts.openSans(
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.black,
    ),

    /// headline5    24.0  regular  0.0
    headline5: GoogleFonts.openSans(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: Colors.black,
    ),

    /// headline6    20.0  medium   0.15
    headline6: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Colors.black,
    ),

    /// subtitle1    16.0  regular  0.15
    subtitle1: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Colors.black,
    ),

    /// subtitle2    14.0  medium   0.1
    subtitle2: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Colors.black,
    ),
  );

  static TextTheme darkText = TextTheme(
    /// body1    16.0  regular  0.5   (bodyText1)
    bodyText1: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Colors.white,
    ),

    /// body2   14.0  regular  0.25  (bodyText2)
    bodyText2: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white,
    ),

    /// headline1    96.0  light   -1.5
    headline1: GoogleFonts.openSans(
      fontSize: 96.0,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      color: Colors.white,
    ),

    /// headline2    60.0  light   -0.5
    headline2: GoogleFonts.openSans(
      fontSize: 60.0,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      color: Colors.white,
    ),

    /// headline3    48.0  regular  0.0
    headline3: GoogleFonts.openSans(
      fontSize: 48.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: Colors.white,
    ),

    /// headline4    34.0  regular  0.25
    headline4: GoogleFonts.openSans(
      fontSize: 34.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Colors.white,
    ),

    /// headline5    24.0  regular  0.0
    headline5: GoogleFonts.openSans(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      color: Colors.white,
    ),

    /// headline6    20.0  medium   0.15
    headline6: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Colors.white,
    ),

    /// subtitle1    16.0  regular  0.15
    subtitle1: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      color: Colors.white,
    ),

    /// subtitle2    14.0  medium   0.1
    subtitle2: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Colors.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.teal,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
      ),
      textTheme: lightText,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.teal,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.teal,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.teal,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
      ),
      textTheme: darkText,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.teal,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.teal,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
