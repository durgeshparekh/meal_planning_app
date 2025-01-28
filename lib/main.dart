import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Add this import
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/authentication/login_screen.dart';
import 'utils/box_name.dart';
import 'utils/themes.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();

    await hiveOpenBox();

    runApp(const MyApp());
  }, (error, stack) {
    debugPrint("Error: ${error.toString()}");
  });
}

hiveOpenBox() async {
  await Hive.openBox(BoxName.userBox);
  await Hive.openBox(BoxName.mealsBox);
  await Hive.openBox(BoxName.groceriesBox);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meal Planning App',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      // darkTheme: Themes.darkTheme,
      // themeMode: ThemeMode.system, // Automatically switch between light and dark mode
      home: appRoute(context),
    );
  }

  appRoute(BuildContext context) {
    var userBox = Hive.box(BoxName.userBox);
    var loggedInUser = userBox.values.firstWhere(
      (user) => user['isLogin'] == true,
      orElse: () => null,
    );
    if (loggedInUser == null) {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }
}
