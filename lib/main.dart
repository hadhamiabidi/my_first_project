import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pfe/bindings/onboarding_binding.dart';
import 'package:pfe/routes/app_pages.dart';
import 'package:pfe/utils/themes.dart';
import 'package:pfe/views/buttom_navigation_page.dart';
import 'package:pfe/views/login_page.dart';
import 'package:pfe/views/onboarding_page.dart';
import 'package:pfe/views/signup_page.dart';

import 'controllers/buttom_navigation_controller.dart';
void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown]
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bottom AppBar',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: Get.put(ButtomNavigationController()).theme,
      home: buttomNavigationController(),
      initialBinding: OnBoardingBinding(),
      getPages: AppPages.pages,
    );
  }

}

