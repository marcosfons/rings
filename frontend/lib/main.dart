import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rings/src/core/routes/routes.dart';
import 'package:rings/src/core/services/hasura/hasura_client.dart';
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
      initialRoute: '/sign_in',
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
      initialBinding:
          BindingsBuilder.put(() => HasuraClient(), permanent: true),
    );
  }
}
