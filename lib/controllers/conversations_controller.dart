import 'package:get/get.dart';
import 'package:pfe/routes/app_routes.dart';

import '../models/conversation_model.dart';

class ConversationsController extends GetxController {
  final conversations = [
    Conversation(
      username: "John Doe",
      latestMessage: "Hey, what's up?",
      image: "https://via.placeholder.com/150",
    ),
    Conversation(
      username: "Jane Smith",
      latestMessage: "Just finished my project!",
      image: "https://via.placeholder.com/150",
    ),
    Conversation(
      username: "Bob Johnson",
      latestMessage: "How's it going?",
      image: "https://via.placeholder.com/150",
    ),
  ].obs;

  void openConversation(int index) {
    Get.toNamed(AppRoutes.chat);
  }
}