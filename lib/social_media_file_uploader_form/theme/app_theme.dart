import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class AppTheme{
  ThemeData get themeData => ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    colorScheme: colorScheme,
    cardTheme: cardTheme,
    textTheme: textTheme,
    progressIndicatorTheme: progressIndicatorTheme,
    appBarTheme: appbarTheme
  );

  Color get scaffoldBackgroundColor => Colors.white;

  AppBarTheme get appbarTheme => AppBarTheme(
    color: Colors.white
  );

  ColorScheme get colorScheme => ColorScheme.fromSeed(
      seedColor: Colors.white,
      secondary: Colors.grey,
      outline: Color.fromRGBO(205, 0, 103, 1),//outline dotted color
      tertiary:Color.fromRGBO(205, 0, 103, 1),//bottom icon color
      errorContainer: Colors.red.shade200,
      error: Colors.red,
      onPrimary: Colors.black
  );

  CardTheme get cardTheme => CardTheme(
    elevation: 0,
    color: Colors.white,
    //shadowColor: Colors.black.withOpacity(0.2),
    /*shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),*/
    margin: const EdgeInsets.all(8),
  );

  TextTheme get textTheme => GoogleFonts.aBeeZeeTextTheme().copyWith(

    headlineLarge: GoogleFonts.aBeeZee(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.aBeeZee(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
    ),
    bodySmall: GoogleFonts.aBeeZee(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.white   ,
    ),
  );

  ProgressIndicatorThemeData get progressIndicatorTheme => ProgressIndicatorThemeData(
      color: Color.fromRGBO(205, 0, 103, 1)
  );

}