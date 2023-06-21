import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../routes/app_routes.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;
  RxList<Map<String, dynamic>> claims = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading.value = true;

      // Fetch the claims collection
      final claimsSnapshot = await _firestore.collection('claims').get();

      // Fetch the users collection
      final usersSnapshot = await _firestore.collection('users').get();
      final usersMap = { for (var doc in usersSnapshot.docs) doc.id : doc.data() };
      claims.clear();
      claims.value = claimsSnapshot.docs.map((doc) {
        final claimData = doc.data();
        final uid = claimData['uid'];

        // Retrieve the user data using the uid
        final userData = usersMap[uid] as Map<String, dynamic>;

        // Merge the claim data with the user data and add claimId
        final mergedData = {
          ...claimData,
          ...userData,
          'claimId': doc.id, // Add claimId to the merged data
        };

        return mergedData;
      }).toList();

      isLoading.value = false;
    } catch (error) {
      hasError.value = true;
      errorMessage.value = error.toString();
      isLoading.value = false;
    }
  }



  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  void showResponseBottomSheet(BuildContext context, dynamic claim) {
    TextEditingController responseController = TextEditingController();

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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Répondre à la réclamation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: responseController,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(width: 1),
                ),
                labelText: 'Votre réponse',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String response = responseController.text;

                // Update the claim's description in Firebase
                try {
                  await FirebaseFirestore.instance
                      .collection('claims')
                      .doc(claim['claimId'])
                      .update({'description': response});
                  fetchData();
                  Get.back();
                } catch (error) {
                  print('Error updating claim description: $error');
                  // Handle error if necessary
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                primary: Colors.green,
              ),
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

}




