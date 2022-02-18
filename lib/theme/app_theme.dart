import 'package:flutter/material.dart';

import 'package:mastermind/theme/colors.dart';

class CustomTheme {
  static ThemeData get defaultTheme {
    return ThemeData(
      primaryColor: CustomColors.primaryDefault.withOpacity(1),
      scaffoldBackgroundColor: Colors.white,

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    );
  }
}
