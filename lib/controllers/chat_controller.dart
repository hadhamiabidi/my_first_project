import 'package:get/get.dart';

import '../models/message_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatController extends GetxController {
  final RxList<Message> messages = <Message>[].obs;
  late String driverId;
  late String currentUserId;

  @override
  void onInit() {
    super.onInit();
    // Get the driver_id from arguments passed to the route
    driverId = Get.arguments as String;

    // Get the current user's ID from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUserId = user.uid;
    } else {
      // Handle the case when the user is not authenticated
      // You can show an error message or redirect to the login screen
    }

    // Fetch messages for the conversation
    fetchMessages();
  }

  void fetchMessages() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('conversations')
          .where('client_id', isEqualTo: currentUserId)
          .where('driver_id', isEqualTo: driverId)
          .get();

      List<Message> fetchedMessages = [];
      for (QueryDocumentSnapshot document in snapshot.docs) {
        Map<String, dynamic>? data = document.data() as Map<String, dynamic>?; // Explicitly cast to Map<String, dynamic>
        if (data != null) {
          Message message = Message.fromJson(data);
          fetchedMessages.add(message);
        }
      }

      // Update the messages list
      messages.addAll(fetchedMessages);
    } catch (error) {
      // Handle the error
    }
  }


  void sendMessage(String text) {

  }
}

