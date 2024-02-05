import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constant.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.rubik(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.rubik(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.rubik(
      fontSize: 14,
      color: customGreyColor,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.rubik(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.rubik(
      fontSize: 14,
      color: Colors.black,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.rubik(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.rubik(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.rubik(
      fontSize: 14,
      color: customGreyColor,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.rubik(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w100,
    ),
    bodySmall: GoogleFonts.rubik(
      fontSize: 14,
      color: Colors.white,
    ),
  );

  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: darkGhostWhite,
      cardColor: Colors.white,
      textTheme: lightTextTheme,
      iconTheme: const IconThemeData(color: Colors.black),
      appBarTheme: AppBarTheme(
        backgroundColor: darkGhostWhite,
        elevation: 0,
        toolbarHeight: 85,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      cardColor: customeBlackColor,
      textTheme: darkTextTheme,
      iconTheme: const IconThemeData(color: Colors.white),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 85,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
        ),
      ),
    );
  }
}
