import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class TrackingController extends GetxController {
  final isTracking = false.obs;
  final Location location = Location();

  void toggleTracking() {
    isTracking.value = !isTracking.value;
    if (isTracking.value==true) {
      startLocationTracking();
    } else {
      stopLocationTracking();
    }
  }

  void startLocationTracking() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
            if(locationData.latitude!=null && locationData.longitude!=null){
              updateLocation(locationData.latitude!, locationData.longitude!);
            }
        });
      }
    });
  }

  void stopLocationTracking() {
    location.onLocationChanged.listen(null).cancel();
  }

  void updateLocation(double latitude, double longitude) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userCollection = FirebaseFirestore.instance.collection('users');
        final userDoc = userCollection.doc(user.uid);
        await userDoc.update({
          'latitude': latitude,
          'longitude': longitude,
        });
      }
    } catch (e) {
      // Handle any potential errors
    }
  }
}