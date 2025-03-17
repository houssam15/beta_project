import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class AppTheme{
  ThemeData get themeData => ThemeData(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: colorScheme,
      cardTheme: cardTheme,
      textTheme: textTheme,
      progressIndicatorTheme: progressIndicatorTheme,
      checkboxTheme: checkboxTheme,
      appBarTheme: appbarTheme
  );

  Color get scaffoldBackgroundColor => Colors.white;

  AppBarTheme get appbarTheme => AppBarTheme(
      color: Colors.white
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

  ColorScheme get colorScheme => ColorScheme.fromSeed(
    seedColor: Colors.white,
    secondary: Colors.grey,
    outline: Colors.blue,
    tertiary:Color.fromRGBO(205, 0, 103, 1),
    errorContainer: Colors.red.shade200,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.black
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
  );

  ProgressIndicatorThemeData get progressIndicatorTheme => ProgressIndicatorThemeData(
      color: Colors.blue.shade200
  );

  CheckboxThemeData get checkboxTheme => CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return Colors.grey; // Grey when disabled
      }
      return const Color.fromRGBO(205, 0, 103, 0.5); // Default color
    }),
    checkColor: WidgetStateProperty.all(Colors.white), // Color of the check mark
    overlayColor: WidgetStateProperty.all(Color.fromRGBO(205, 0, 103, 0.05)), // Color of the overlay when tapped
    splashRadius: 20,  // Radius of the splash effect
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.transparent, // Border color
        width: 2.0, // Border width
      ),
    ),
    side: BorderSide(
      color: Color.fromRGBO(205, 0, 103, 0.1), // Color when selected
      width: 2.0,
    ),
  );
}