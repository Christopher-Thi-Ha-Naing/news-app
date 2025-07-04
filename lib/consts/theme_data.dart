import 'package:flutter/material.dart';
import 'package:news_app/consts/global_color.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarkTheme ? darkScaffoldColor : lightScaffoldColor,
      primaryColor: isDarkTheme ? darkCardColor : lightCardColor,
      hintColor: isDarkTheme ? Colors.grey.shade400 : Colors.grey.shade700,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: isDarkTheme ? Colors.white : Colors.black,
        selectionColor: Colors.blue,

        // selectionHandleColor: Colors.blue,
      ),
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: isDarkTheme ? Colors.white : Colors.black,
        displayColor: isDarkTheme ? Colors.white : Colors.black,
      ),
      cardColor: isDarkTheme ? darkCardColor : lightCardColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      colorScheme: ThemeData().colorScheme
          .copyWith(
            onSecondary: isDarkTheme ? Colors.white : Colors.black,
            secondary: isDarkTheme ? darkIconsColor : lightIconsColor,
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          )
          .copyWith(
            surface: isDarkTheme ? darkBackgroundColor : lightBackgroundColor,
          ),
    );
  }
}
