import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pfe/controllers/signup_controller.dart';

import '../config/app_styles.dart';

class SignupPage extends StatelessWidget{
  final _controller = RegisterController();
  RegisterController controller = Get.put(RegisterController());
  SignupPage({ Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),

            ],
          ),
        ),
      ),
    );
  }
    _header(context) {
      return Column(
        children: [
          Text("S inscrire", style: AppStyles.neutralBlack20W6Style,),
          const SizedBox(height: 10,)
        ],
      );
    }
    _inputField(context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        TextField(
        controller: controller.nomField,
        decoration: InputDecoration(
            hintText: "nom",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person)),
      ),


        const SizedBox(height: 10),
      TextField(
      controller: controller.prenomField,
      decoration: InputDecoration(
          hintText: "prenom",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
          filled: true,
          prefixIcon: const Icon(Icons.person)),
      obscureText: true,
      ),
      const SizedBox(height: 10),

      TextField(
      controller: controller.EmailField,
      decoration: InputDecoration(
      hintText: "E-mail",
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none),
      fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
      filled: true,
      prefixIcon: const Icon(Icons.contact_mail)),
      obscureText: true,
      ),
      const SizedBox(height: 10),


      TextField(
      controller: controller.numField,
      decoration: InputDecoration(
      hintText: "Contact",
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none),
      fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
      filled: true,
      prefixIcon: const Icon(Icons.contact_phone_outlined)),
      obscureText: true,
      ),
      const SizedBox(height: 10),

      TextField(
      controller: controller.passwordField,
      decoration: InputDecoration(
      hintText: "mot de passe",
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none),
      fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
      filled: true,
      prefixIcon: const Icon(Icons.contact_mail)),
      obscureText: true,
      ),
      const SizedBox(height: 10),

      TextField(
      controller: controller.confirmField,
      decoration: InputDecoration(
      hintText: " Confirmer mot de passe",
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none),
      fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
      filled: true,
      prefixIcon: const Icon(Icons.contact_mail)),
      obscureText: true,
      ),
      const SizedBox(height: 10),
      );
  ],
  }
}



