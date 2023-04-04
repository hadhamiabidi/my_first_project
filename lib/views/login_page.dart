import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_styles.dart';
import '../controllers/login_controller.dart';
import '../widgets/submit_button.dart';

class LoginPage extends StatelessWidget {
  LoginController controller = Get.put(LoginController());
  LoginPage({Key? key}) : super(key: key);

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
              _forgotPassword(context),
              _signup(context),
            ],
          )
        ),
      ),
    );
  }
  _header(context) {
    return Column(
      children:  [
        Text("Content de vous revoir",style: AppStyles.neutralBlack20W6Style,),
        const SizedBox(height: 10),
        const Text("Entrez vos identifiants pour vous connecter",style: AppStyles.neutralBlack14W4Style,),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller.emailField,
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller.passwordField,
          decoration: InputDecoration(
            hintText: "Mot de passe",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password_rounded),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        SubmitButton(label: "Connexion", onPressed: () {controller.handeSignIn(context);})
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(onPressed: () {controller.goToForgotPassword();}, child: const Text("Mot de passe oublié?"));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Vous n'avez pas de compte ?",style: AppStyles.neutralBlack14W4Style,),
        TextButton(onPressed: () {controller.goToRegister();}, child: const Text("S'inscrire"))
      ],
    );
  }
}