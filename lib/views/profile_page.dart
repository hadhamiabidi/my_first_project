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
            const SizedBox(height: 10),
            _buildProfileName(context, _controller.currentUser.value.firstName + " " + _controller.currentUser.value.lastName),
            const SizedBox(height: 14),
            _buildHeading(context, "Détails personnels"),
            const SizedBox(height: 6),
            _buildDetailsCard(_controller),
          ],
        )),
      ),
    );
  }

  Widget _buildHeader(ProfileController controller) {
    final String firstName = controller.currentUser.value.firstName;
    final String lastName = controller.currentUser.value.lastName;
    final String initials = (firstName.isNotEmpty ? firstName[0] : '') +
        (lastName.isNotEmpty ? lastName[0] : '');

    final String profilePictureUrl = controller.currentUser.value.profilePictureUrl;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 50,
                child: profilePictureUrl.isNotEmpty
                    ? ClipOval(
                  child: Image.network(
                    profilePictureUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                )
                    : Text(
                  initials.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    controller.addPicture();
                  },
                  child: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
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
          style: const TextStyle(
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
          style: const TextStyle(fontSize: 16),
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
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.dashboard_customize),
              title: const Text("À propos de nous"),
              onTap: () => controller.goToAboutUs(),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Paramètres"),
              onTap: () => controller.goToSettings(),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Déconnexion"),
              onTap: () => controller.logout(),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Suivre l'emplacement"),
              onTap: ()=>controller.goToTrackingScreen(),
            ),
          ],
        ),
      ),
    );
  }

}
