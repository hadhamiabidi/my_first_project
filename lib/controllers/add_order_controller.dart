import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfe/config/base_controller.dart';

import '../routes/app_routes.dart';

class AddOrderController extends GetxController with BaseController {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController startLocationController = TextEditingController();
  final TextEditingController destinationLocationController =
  TextEditingController();
  final TextEditingController deliveryDateController = TextEditingController();

  void addOrder() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final price = priceController.text.trim();
    final startLocation = startLocationController.text.trim();
    final destinationLocation = destinationLocationController.text.trim();
    final deliveryDate = deliveryDateController.text.trim();

    // Validate title
    if (title.isEmpty) {
      Get.snackbar("Error", "Please enter a title");
      return;
    }

    // Validate description
    if (description.isEmpty) {
      Get.snackbar("Error", "Please enter a description");
      return;
    }

    // Validate price
    if (price.isEmpty) {
      Get.snackbar("Error", "Please enter a price");
      return;
    }
    if (double.tryParse(price) == null) {
      Get.snackbar("Error", "Please enter a valid price");
      return;
    }

    // Validate start location
    if (startLocation.isEmpty) {
      Get.snackbar("Error", "Please enter a start location");
      return;
    }

    // Validate destination location
    if (destinationLocation.isEmpty) {
      Get.snackbar("Error", "Please enter a destination location");
      return;
    }

    // Validate delivery date
    if (deliveryDate.isEmpty) {
      Get.snackbar("Error", "Please enter a delivery date");
      return;
    }
    if (DateTime.tryParse(deliveryDate) == null) {
      Get.snackbar("Error", "Please enter a valid delivery date (yyyy-mm-dd)");
      return;
    }

    // Add order to Firestore
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Get.snackbar("Error", "No user signed in");
      return;
    }
    showLoading();
    FirebaseFirestore.instance.collection('orders').add({
      'title': title,
      'description': description,
      'price': double.parse(price),
      'start_location': startLocation,
      'destination_location': destinationLocation,
      'delivery_date': DateTime.parse(deliveryDate),
      'user_id': currentUser.uid,
      'status':0
    }).then((value) {
      hideLoading();
      Get.offAllNamed(AppRoutes.dashboard);
      Get.snackbar("Success", "Order added successfully");
    }).catchError((error) {
      hideLoading();
      Get.snackbar("Error", "Failed to add order: $error");
    });
  }


  selectDeliveryDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
      );
      if (selectedTime != null) {
        DateTime selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        deliveryDateController.text =
            selectedDateTime.toString().split('.').first;
      }
    }
  }

  selectLocationAddress(TextEditingController controller) async {
    LatLng? selectedLatLng;
    if (controller.text.isNotEmpty) {
      selectedLatLng = LatLng(
        double.parse(controller.text.split(",")[0]),
        double.parse(controller.text.split(",")[1]),
      );
    }

    selectedLatLng = await showDialog(
      context: Get.context!,
      builder: (context) {
        LatLng? result;
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.maxFinite,
            height: 400,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedLatLng ?? const LatLng(34.000, 9.000), // Set Tunisia coordinates here (latitude: 34, longitude: 9)
                zoom: 6,
              ),
              onTap: (LatLng latLng) {
                result = latLng;
                Navigator.of(context).pop(result);
              },
              markers: selectedLatLng != null ? {
                Marker(
                  markerId: MarkerId('selected-location'),
                  position: selectedLatLng,
                ),
              } : {},
            ),
          ),
        );
      },
    );
    if (selectedLatLng != null) {
      controller.text = "${selectedLatLng.latitude}, ${selectedLatLng.longitude}";
    }
  }


}
