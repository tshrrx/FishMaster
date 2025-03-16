import 'package:fishmaster/utils/theme/elevated_button_theme.dart';
import 'package:flutter/material.dart';
import 'package:fishmaster/utils/theme/text_theme.dart';

class FAppTheme {
  FAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true, // Corrected property name
    fontFamily: 'Poppins', // Fixed string syntax
    brightness: Brightness.light, // Fixed case
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: FTextTheme.lightTextTheme, // Fixed reference
    elevatedButtonTheme:FElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    textTheme: FTextTheme.darkTextTheme, // Assuming this exists
    elevatedButtonTheme:FElevatedButtonTheme.darkElevatedButtonTheme,
  );
}
