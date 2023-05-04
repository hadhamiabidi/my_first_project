import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe/controllers/forget_password_controller.dart';
import '../widgets/submit_button.dart';

import '../config/app_styles.dart';

class ForgetPasswordPage extends StatelessWidget {
   ForgetPasswordPage({Key? key}) : super(key: key);
  ForgetPasswordController forgetPasswordController = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _header(context),
                _inputField(context)
              ],
            )
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children:  [
        Text("Avez-vous oublié votre mot de passe",style: AppStyles.neutralBlack16W7Style,),
        const SizedBox(height: 10),
        const Text("Veuillez entrer votre email pour réinitialiser le mot de passe",style: AppStyles.neutralBlack14W4Style,textAlign: TextAlign.center,),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        TextField(
          controller: forgetPasswordController.emailField,
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
        SubmitButton(label: "Connexion", onPressed: () => {forgetPasswordController.handleForgetPassword()})
      ],
    );
  }

}
