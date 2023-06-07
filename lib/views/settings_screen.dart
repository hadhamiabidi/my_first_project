import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController _settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Paramètres',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: _settingsController.currentPasswordController,
                obscureText: !_settingsController.isCurrentPasswordVisible.value,
                decoration: InputDecoration(
                  labelText: 'Mot de passe actuel',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _settingsController.toggleCurrentPasswordVisibility();
                    },
                    icon: Icon(_settingsController.isCurrentPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              ),
            )),
            SizedBox(height: 16),
            Obx(() => Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: _settingsController.currentPasswordController,
                obscureText: !_settingsController.isCurrentPasswordVisible.value,
                decoration: InputDecoration(
                  labelText: 'Nouveau mot de passe',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _settingsController.toggleCurrentPasswordVisibility();
                    },
                    icon: Icon(_settingsController.isCurrentPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                  ),
                ),
              ),
            )),
            SizedBox(height: 24),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  _settingsController.changePassword();
                },
                child: Text('Changer le mot de passe'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
