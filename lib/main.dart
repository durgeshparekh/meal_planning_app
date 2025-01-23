import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import 'app_bindings.dart';
import 'utils/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recipe App',
      initialRoute: AppRoutes.home,
      initialBinding: AppBindings(),
      getPages: AppRoutes.pages,
      theme: Themes.lightTheme,
    );
  }
}
