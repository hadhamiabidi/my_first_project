import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  const MessageItem({
    Key? key,
    required this.sender,
    required this.text,
    this.isMe = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = isMe ? Colors.grey[300] : Colors.blue[200];
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final margin = isMe ? EdgeInsets.only(left: 100, top: 8, right: 10) : EdgeInsets.only(right: 100, top: 8, left: 10);

    return Container(
      margin: margin,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: align,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
