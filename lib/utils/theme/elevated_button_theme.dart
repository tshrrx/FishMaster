import 'package:flutter/material.dart';

class FElevatedButtonTheme {
  FElevatedButtonTheme._(); // To avoid creating instances

  /// Light Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Color.fromRGBO(51, 108, 138, 1),
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(
        color: Color.fromRGBO(51, 108, 138, 1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 18,

        color: Colors.white,
        fontWeight: FontWeight.w600, // Fixed fontWeight
      ),
      shape: RoundedRectangleBorder(
        // Fixed class name
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  /// Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor:
          Colors.blueGrey, // Changed to blueGrey for dark mode contrast
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: Colors.blueGrey),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
