import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rings',
      theme: ThemeData(primarySwatch: Colors.blue),
			initialRoute: '/home',
			getPages: Routes.pages,
    );
  }
}