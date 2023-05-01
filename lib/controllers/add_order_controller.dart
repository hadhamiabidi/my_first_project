import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddOrderController extends GetxController {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController startLocationController = TextEditingController();
  final TextEditingController destinationLocationController =
  TextEditingController();
  final TextEditingController deliveryDateController = TextEditingController();

  addOrder() {}

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
                target: selectedLatLng ?? LatLng(37.7749, -122.4194),
                zoom: 12,
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
