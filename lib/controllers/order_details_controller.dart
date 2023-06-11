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
    print("Moussa order");
    print(_order.driver_uid);
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
    // Update the status attribute of the order to 1 in Firestore
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(_order.uid)
        .update({
      'status': 1,
      'driver_uid': FirebaseAuth.instance.currentUser!.uid, // Replace 'your_driver_uid_here' with the actual driver UID
    });
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

  void goToConversation(String? driver_id) async {
    // Get the current user's email
    String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;

    // Query the "users" collection to find the document with the driver's UID
    var driverSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(driver_id)
        .get();

    // Check if the driver document exists
    if (driverSnapshot.exists) {
      var driverDocument = driverSnapshot.data() as Map<String, dynamic>;

      // Get the driver's email
      String driverID = driverSnapshot.id;

      // Get the driver's chat ID
      String? driverChatId = driverDocument['chat_id'];

      if (driverChatId != null) {
        // Navigate to the existing chat room with the driver using the chat ID
        Get.toNamed(AppRoutes.chat, arguments: {
          'chat_id': driverChatId,
          'friendEmail': driverID,
        });
      } else {
        // Create a new chat room
        CollectionReference chatsCollection = FirebaseFirestore.instance.collection('chats');
        DocumentReference newChatDoc = await chatsCollection.add(<String, dynamic>{});

        // Update the chat ID for the driver
        await FirebaseFirestore.instance
            .collection('users')
            .doc(driver_id)
            .collection("chats")
            .doc(newChatDoc.id)
            .set({
              'chat_id': newChatDoc.id,
              'connection': FirebaseAuth.instance.currentUser!.uid,
              'lastTime': DateTime.now(),
              'total_unread': 1,
            });


        // Update the chat ID for the current user
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("chats")
            .doc(newChatDoc.id)
            .set({
              'chat_id': newChatDoc.id,
              'connection': driverID,
              'lastTime': DateTime.now(),
              'total_unread': 1,
            });

        // Navigate to the newly created chat room
        print("created chat room");
        print(newChatDoc.id);
        print(driverID);
        Get.toNamed(
          AppRoutes.chat,
          arguments: {
            'chat_id': newChatDoc.id,
            'friendEmail': driverID,
          },
        );
      }
    } else {
      // Handle the case where the driver document does not exist
      Get.snackbar('Error', 'Driver not found.');
    }
  }

}
