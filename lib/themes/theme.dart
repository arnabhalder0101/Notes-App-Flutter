import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.deepPurple.shade50,
    primary: Colors.deepPurple.shade100,
    onPrimary: Colors.deepPurple.shade200,
    secondary: Colors.deepPurple.shade300,
    tertiary: Colors.deepPurple.shade400,
    inversePrimary: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color.fromARGB(255, 123, 80, 197),
    primary: const Color.fromARGB(255, 151, 121, 202),
    onPrimary: Colors.deepPurple.shade200,
    secondary: Colors.deepPurple.shade100,
    tertiary: Colors.deepPurple.shade200,
    inversePrimary: Colors.white,
  ),
);
