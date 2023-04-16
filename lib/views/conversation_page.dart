import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/conversations_controller.dart';
import '../widgets/conversation_item.dart';

class ConversationsPage extends StatelessWidget {
  final controller = Get.put(ConversationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: controller.conversations.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Handle item click
                controller.openConversation(index);
              },
              child: ConversationItem(
                conversation: controller.conversations[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
