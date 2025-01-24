import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Add this import
import 'screens/home_screen.dart';
import 'utils/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Change MaterialApp to GetMaterialApp
      title: 'Meal Planning App',
       theme: Themes.lightTheme,
      home: HomeScreen(),
    );
  }
}
