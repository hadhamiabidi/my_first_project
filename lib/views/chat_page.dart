import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../widgets/message_item.dart';

class ChatPage extends StatelessWidget {
  final ChatController _chatController = Get.put(ChatController());

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // remove default back arrow button
        titleSpacing: 0, // remove padding around the title
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/user_image.jpg'),
            ),
            SizedBox(width: 8),
            Text(
              'John Doe',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: _chatController.messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _chatController.messages[index];
                return MessageItem(
                  sender: message.sender,
                  text: message.text,
                );
              },
            )),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final text = _textController.text.trim();
                    if (text.isNotEmpty) {
                      _chatController.sendMessage(text);
                      _textController.clear();
                    }
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
