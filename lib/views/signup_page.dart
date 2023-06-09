import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe/controllers/signup_controller.dart';

import '../config/app_styles.dart';
import '../widgets/build_text_field.dart';
import '../widgets/submit_button.dart';

class SignupPage extends StatelessWidget {
  final controller = Get.put(SignupController());

  SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin:const  EdgeInsets.all(24),
        child:SafeArea(
          child: SingleChildScrollView(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "S'inscrire",
                      style: AppStyles.neutralBlack20W6Style,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildTextField(
                      hintText: "Nom",
                      prefixIcon: Icons.person,
                      controller: controller.nomField,
                    ),
                    const SizedBox(height: 10),
                    buildTextField(
                      hintText: "Prénom",
                      prefixIcon: Icons.person,
                      controller: controller.prenomField,
                    ),
                    const SizedBox(height: 10),
                    buildTextField(
                      hintText: "E-mail",
                      prefixIcon: Icons.contact_mail,
                      controller: controller.emailField,
                    ),
                    const SizedBox(height: 10),
                    buildTextField(
                      hintText: "Contact",
                      prefixIcon: Icons.contact_phone_outlined,
                      controller: controller.numField,
                    ),
                    const SizedBox(height: 10),
                    buildTextField(
                      hintText: "Mot de passe",
                      prefixIcon: Icons.lock,
                      controller: controller.passwordField,
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    buildTextField(
                      hintText: "Confirmer mot de passe",
                      prefixIcon: Icons.lock,
                      controller: controller.confirmField,
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: controller.isDriver.value,
                          onChanged: (value) {
                            controller.isDriver.value = false;
                          },
                        ),
                        Text("Client"),
                        const SizedBox(width: 10),
                        Radio(
                          value: true,
                          groupValue: controller.isDriver.value,
                          onChanged: (value) {
                            controller.isDriver.value = true;
                          },
                        ),
                        Text("Chauffeur"),
                      ],
                    ),),
                    const SizedBox(height: 10),
                    SubmitButton(label: "Enregistrer", onPressed: () {controller.handeSignUp(context);})
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
