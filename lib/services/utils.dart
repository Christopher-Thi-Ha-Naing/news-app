import 'package:flutter/material.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get gettheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  Color get getColor => gettheme ? Colors.white : Colors.black;

  Color get baseShimmerColor =>
      gettheme ? Colors.grey.shade500 : Colors.grey.shade200;
  Color get highlightShimmerColor =>
      gettheme ? Colors.grey.shade700 : Colors.grey.shade400;

  Color get widgetShimmerColor =>
      gettheme ? Colors.grey.shade600 : Colors.grey.shade100;
}
