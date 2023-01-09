import 'package:flutter/material.dart';
import 'package:quitanda_com_getx/src/pages/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      title: 'Greengrocer',
      home: const SplashScreen(),
    );
  }
}
