import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pfe/views/login_page.dart';
import 'package:pfe/views/onboarding_page.dart';
import 'package:pfe/views/signup_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {
    return GetMaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    initialRoute: "/" ,
    routes:
    {
      "/login": (contexte) => const Login(authType: AuthType.login),
      "/signup": (contexte) => const Signup(authType: AuthType.Signup),
    }
    );
  }

}

