import 'package:flutter/material.dart';
import 'package:netflixx/common/utils.dart';
import 'package:netflixx/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Netflix',
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white),bodyMedium: TextStyle(color: white)),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 30, 28, 30))
                .copyWith(background: Color.fromARGB(255, 0, 0, 0))),
                home: SplashScreen(),);
  }
}
