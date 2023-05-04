import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? uid; // changed to nullable

  final String title;
  final String description;
  final int status;
  final double price;

  final String user_id;
  final String start_location;
  final String destination_location;
  final DateTime delivery_date;

  final String? driver_id; // new nullable field for driver ID

  OrderModel({
    required this.title,
    required this.description,
    required this.status,
    required this.price,
    required this.user_id,
    required this.start_location,
    required this.destination_location,
    required this.delivery_date,
    this.driver_id, // made optional with default null value
    this.uid, // made optional with default null value
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String uid) {
    return OrderModel(
      title: map['title'],
      description: map['description'],
      status: map['status'],
      price: map['price'],
      user_id: map['user_id'],
      start_location: map['start_location'],
      destination_location: map['destination_location'],
      delivery_date: (map['delivery_date'] as Timestamp).toDate(),
      driver_id: map['driver_id'],
      uid: uid,
    );
  }
}
