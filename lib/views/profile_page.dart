import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Column(
          children: [
            _buildHeader(_controller),
            SizedBox(height: 10),
            _buildProfileName(context, _controller.currentUser.value.firstName + " " + _controller.currentUser.value.lastName),
            SizedBox(height: 14),
            _buildHeading(context, "Détails personnels"),
            SizedBox(height: 6),
            _buildDetailsCard(_controller),
          ],
        )),
      ),
    );
  }
}

Widget _buildHeader(ProfileController controller) {
  final String firstName = controller.currentUser.value.firstName;
  final String lastName = controller.currentUser.value.lastName;
  final String initials = (firstName.isNotEmpty ? firstName[0] : '') +
      (lastName.isNotEmpty ? lastName[0] : '');

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 50,
          child: Text(
            initials.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildProfileName(BuildContext context, String name) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.80,
    child: Center(
      child: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}

Widget _buildHeading(BuildContext context, String heading) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.80,
    child: Center(
      child: Text(
        heading,
        style: TextStyle(fontSize: 16),
      ),
    ),
  );
}

Widget _buildDetailsCard(ProfileController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 4,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.email),
            title: Text(FirebaseAuth.instance.currentUser!.email!),
          ),
          Divider(
            height: 0.6,
            color: Colors.black87,
          ),
          ListTile(
            leading: Icon(Icons.dashboard_customize),
            title: Text("À propos de nous"),
            onTap: () => controller.goToAboutUs(),
          ),
          Divider(
            height: 0.6,
            color: Colors.black87,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Paramètres"),
            onTap: () => controller.goToSettings(),
          ),
          Divider(
            height: 0.6,
            color: Colors.black87,
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Déconnexion"),
            onTap: () => controller.logout(),
          ),
        ],
      ),
    ),
  );
}
