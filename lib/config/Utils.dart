import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Utils {
  static LatLng parseLatLng(String latLngString) {
    final latLngList = latLngString.split(',');
    final lat = double.tryParse(latLngList[0]) ?? 0.0;
    final lng = double.tryParse(latLngList[1]) ?? 0.0;
    return LatLng(lat, lng);
  }

  static Future<String> getAddressFromLatLng(LatLng latLng) async {
    const apiKey = 'AIzaSyD3K_h-G_d2mfs4nGzV2VxP8vLulTlaCJk';
    final endpoint =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final address = result['results'][0]['formatted_address'];
      return address;
    } else {
      throw Exception('Failed to fetch address from the Geocoding API');
    }
  }
}
