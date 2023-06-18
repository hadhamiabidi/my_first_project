import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe/config/base_controller.dart';

import '../models/claim_model.dart';

class ClaimsController extends GetxController with BaseController {
  final RxList<Claim> claims = <Claim>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchClaims();
  }

  Future<void> fetchClaims() async {
    showLoading();
    final claimsCollection = FirebaseFirestore.instance.collection('claims');
    final querySnapshot = await claimsCollection.get();

    final newClaims = <Claim>[];
    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final claim = Claim.fromJson({
        'uid': doc.id,
        ...data,
      });
      newClaims.add(claim);
    }

    claims.addAll(newClaims);
    hideLoading();
  }

  void addClaim(String title) {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    String currentDate = DateTime.now().toString();

    Claim newClaim = Claim(
      title: title,
      date: currentDate,
      description: '',
      uid: currentUserId, // Add the current user's UID
      // Add any other necessary properties
    );

    // Add the new claim to the claims collection in Firebase
    FirebaseFirestore.instance
        .collection('claims')
        .add(newClaim.toMap())
        .then((value) {
      // Claim added successfully
      // You can add any additional logic here if needed
    }).catchError((error) {
      // Error occurred while adding claim
      // You can handle the error and show an error message if needed
    });

    // Close the bottom sheet
    Get.back();
  }


  void addNewClaim() {
    TextEditingController titleController = TextEditingController();

    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Titre',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 50,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text.trim();
                if (title.isNotEmpty) {
                  addClaim(title);
                  Get.back();
                } else {
                  // Show an error message or handle empty input
                }
              },
              child: Text('Enregistrer'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
