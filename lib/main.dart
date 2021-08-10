import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/routes.dart';
import 'package:rings/src/core/themes/light_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rings',
      theme: lightTheme,
			themeMode: ThemeMode.light,
			initialRoute: '/select_client',
			getPages: Routes.pages,
    );
  }
}