import 'dart:async';
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
  RxSet<Marker> markers = <Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    var arguments = Get.arguments;
    isDriver = arguments['isDriver'];
    _order = arguments['item'] as OrderModel;

    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!isDriver) {
        updateDriverPosition();
      }
    });
  }

  GoogleMapController getMapController() => mapController;

  CameraPosition getInitialCameraPosition() {
    if (isDriver) {
      return CameraPosition(
        target: Utils.parseLatLng(_order.start_location),
        zoom: 10,
      );
    } else {
      return CameraPosition(
        target: LatLng(
          (Utils.parseLatLng(_order.start_location).latitude +
              Utils.parseLatLng(_order.destination_location).latitude) /
              2,
          (Utils.parseLatLng(_order.start_location).longitude +
              Utils.parseLatLng(_order.destination_location).longitude) /
              2,
        ),
        zoom: 10,
      );
    }
  }

  Set<Marker> getMarkers() {
    var defaultMarkers = {
      Marker(
        markerId: const MarkerId('Lieu de départ'),
        position: Utils.parseLatLng(_order.start_location),
        icon: BitmapDescriptor.defaultMarker,
      ),
      Marker(
        markerId: const MarkerId('Lieu de destination'),
        position: Utils.parseLatLng(_order.destination_location),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    };

    if (isDriver) {
      defaultMarkers.add(
        Marker(
          markerId: const MarkerId('Driver'),
          position: Utils.parseLatLng(_order.start_location),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    return markers.toSet().union(defaultMarkers);
  }

  Set<Polyline> getPolylines() {
    return {
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
  }

  OrderModel getOrder() => _order;

  bool isCancelled() => false;

  void cancelOrder() async {
    showLoading();
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(_order.uid)
        .update({'status': -1});
    hideLoading();
    Get.snackbar('Order Canceled', 'The order has been canceled.');
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void acceptOrder() async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(_order.uid)
        .update({
      'status': 1,
      'driver_uid': FirebaseAuth.instance.currentUser!.uid,
    });
    Get.snackbar('Order Accepted', 'The order has been accepted.');
    Get.offAllNamed(AppRoutes.bottomNavigation);
  }

  void setDelivered() async {
    showLoading();
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(_order.uid)
        .update({'status': 2});
    hideLoading();
    Get.offAllNamed(AppRoutes.bottomNavigation);
  }

  void goToConversation(String? driverId) async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    var currentUserSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get();

    if (currentUserSnapshot.exists) {
      var currentUserDocument =
      currentUserSnapshot.data() as Map<String, dynamic>;

      String currentUserEmail = currentUserSnapshot.id;

      CollectionReference currentUserChatsCollection =
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection("chats");

      var querySnapshot = await currentUserChatsCollection
          .where('connection', isEqualTo: driverId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var chatDocument = querySnapshot.docs.first;

        String chatId = chatDocument.id;
        Get.toNamed(AppRoutes.chat, arguments: {
          'chat_id': chatId,
          'friendEmail': driverId,
        });
      } else {
        CollectionReference chatsCollection =
        FirebaseFirestore.instance.collection('chats');

        DocumentReference newChatDoc =
        await chatsCollection.add(<String, dynamic>{});

        await currentUserChatsCollection.doc(newChatDoc.id).set({
          'chat_id': newChatDoc.id,
          'connection': driverId,
          'lastTime': DateTime.now(),
          'total_unread': 1,
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(driverId)
            .collection("chats")
            .doc(newChatDoc.id)
            .set({
          'chat_id': newChatDoc.id,
          'connection': currentUserId,
          'lastTime': DateTime.now(),
          'total_unread': 1,
        });

        print("created chat room");
        print(newChatDoc.id);
        print(driverId);
        Get.toNamed(
          AppRoutes.chat,
          arguments: {
            'chat_id': newChatDoc.id,
            'friendEmail': driverId,
          },
        );
      }
    } else {
      Get.snackbar('Error', 'User not found.');
    }
  }

  void updateDriverPosition() async {
    print("updateDriverPosition");
    
    var driverSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_order.driver_uid)
        .get();

    if (driverSnapshot.exists) {
      var driverData = driverSnapshot.data();
      print(driverData?["firstName"]);

      double latitude = driverData?['latitude'];
      double longitude = driverData?['longitude'];
      print(latitude);
      print(longitude);
      Marker driverMarker = Marker(
        markerId: const MarkerId('Driver'),
        position: LatLng(latitude, longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      markers.removeWhere((marker) => marker.markerId.value == 'Driver');
      markers.add(driverMarker);
    }
  }
}
