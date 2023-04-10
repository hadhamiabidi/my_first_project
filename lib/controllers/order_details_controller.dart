import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfe/models/order_model.dart';

class OrderDetailsController extends GetxController {
  late GoogleMapController mapController;
  late Order _order;

  @override
  void onInit() {
    super.onInit();
    _order = Order(
        title: 'Delivery 1',
        startAddress: '123 Main St',
        destinationAddress: '456 Elm St',
        status: 'Pending',
        price: 123
    );
  }

  GoogleMapController getMapController() => mapController;

  CameraPosition getInitialCameraPosition() => CameraPosition(
    target: const LatLng(37.4219999, -122.0840575),
    zoom: 10,
  );

  Set<Marker> getMarkers() => {
    const Marker(
      markerId: MarkerId('start'),
      position: LatLng(37.4219999, -122.0840575),
      icon: BitmapDescriptor.defaultMarker,
    ),
    Marker(
      markerId: const MarkerId('destination'),
      position: const LatLng(37.42796133580664, -122.085749655962),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ),
  };

  Set<Polyline> getPolylines() => {
    const Polyline(
      polylineId: PolylineId('route'),
      points: [
        LatLng(37.4219999, -122.0840575),
        LatLng(37.42796133580664, -122.085749655962),
      ],
      color: Colors.blue,
      width: 4,
    ),
  };

  String getStartAddress() => '123 Main St, San Francisco, CA';

  String getDestinationAddress() => '456 Elm St, Mountain View, CA';

  Order getOrder() => _order;

  bool isCancelled() => false;

  void cancelOrder() {
    // Implement cancel order logic
  }
}
