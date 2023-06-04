import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfe/config/Utils.dart';
import 'package:pfe/config/base_controller.dart';
import 'package:pfe/models/order_model.dart';
import 'package:pfe/routes/app_routes.dart';

class OrderDetailsController extends GetxController with BaseController {
  late GoogleMapController mapController;
  late OrderModel _order;
  var isDriver = false;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    isDriver = arguments['isDriver'];
    _order = arguments['item'] as OrderModel;
  }


  GoogleMapController getMapController() => mapController;

  CameraPosition getInitialCameraPosition() =>  CameraPosition(
    target: Utils.parseLatLng(_order.start_location),
    zoom: 10,
  );

  Set<Marker> getMarkers() => {
     Marker(
      markerId: const  MarkerId('Lieu de départ'),
      position: Utils.parseLatLng(_order.start_location),
      icon: BitmapDescriptor.defaultMarker,
    ),
    Marker(
      markerId: const MarkerId('Lieu de destination'),
      position:  Utils.parseLatLng(_order.destination_location),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
  };

  Set<Polyline> getPolylines() => {
     Polyline(
      polylineId: const PolylineId('route'),
      points: [
        Utils.parseLatLng(_order.start_location),
        Utils.parseLatLng(_order.destination_location),
      ],
      color: Colors.blue,
      width: 4,
    ),
  };

  OrderModel getOrder() => _order;

  bool isCancelled() => false;

  void cancelOrder() async {
    showLoading();
    // Update the status attribute of the order to -1 in Firestore
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(_order.uid)
        .update({'status': -1});
    hideLoading();
    // Display a success message to the user
    Get.snackbar('Order Canceled', 'The order has been canceled.');
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void acceptOrder() async {
    showLoading();

    // Update the status attribute of the order to 1 in Firestore
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(_order.uid)
        .update({
      'status': 1,
      'driver_uid': FirebaseAuth.instance.currentUser!.uid, // Replace 'your_driver_uid_here' with the actual driver UID
    });
    hideLoading();
    // Display a success message to the user
    Get.snackbar('Order Accepted', 'The order has been accepted.');
    // Navigate to the appropriate page
    Get.offAllNamed(AppRoutes.bottomNavigation);
  }

  setDelivred() async {
    showLoading();

    // Update the status attribute of the order to 1 in Firestore
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(_order.uid)
        .update({
      'status': 2,
    });
    hideLoading();
    Get.offAllNamed(AppRoutes.bottomNavigation);
  }

  void goToConversation(String? driver_id) {
    Get.toNamed(AppRoutes.chat, arguments: driver_id);
  }

}
