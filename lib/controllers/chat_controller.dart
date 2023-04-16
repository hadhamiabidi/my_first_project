import 'package:get/get.dart';

import '../models/message_model.dart';

class ChatController extends GetxController {
  final RxList<Message> messages = <Message>[].obs;

  void sendMessage(String text) {
    messages.add(Message(
      sender: 'Me',
      text: text,
      timestamp: DateTime.now(),
    ));
  }
}