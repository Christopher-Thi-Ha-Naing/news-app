import 'package:flutter/material.dart';
import 'package:news_app/consts/theme_data.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Need it to access the theme Provider
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  //Fetch the current theme
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            //Notify about theme changes
            return themeChangeProvider;
          },
        ),
      ],
      child:
      //Notify about theme changes
      Consumer<ThemeProvider>(
        builder: (context, themeChangeProvider, ch) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blog',
            theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
            home: const HomeScreen(),
            routes: const {},
          );
        },
      ),
    );
  }
}
