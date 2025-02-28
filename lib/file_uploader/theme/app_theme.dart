import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class AppTheme{
  ThemeData get themeData => ThemeData(
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    colorScheme: colorScheme,
    cardTheme: cardTheme,
    textTheme: textTheme,
    progressIndicatorTheme: progressIndicatorTheme
  );

  Color get scaffoldBackgroundColor => Color(0xFFF6F9FE);

  ColorScheme get colorScheme => ColorScheme.fromSeed(
      seedColor: Colors.white,
      secondary: Colors.grey,
      outline: Colors.blue,
      tertiary:Colors.blue,
      errorContainer: Colors.red.shade200,
      error: Colors.red,
  );

  CardTheme get cardTheme => CardTheme(
    elevation: 8,
    color: Colors.white,
    shadowColor: Colors.black.withOpacity(0.2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
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
      color: Colors.white,
    ),
  );
  
  ProgressIndicatorThemeData get progressIndicatorTheme => ProgressIndicatorThemeData(
    color: Colors.blue.shade200
  );

}