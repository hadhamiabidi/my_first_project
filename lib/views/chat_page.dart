import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class Chat  extends StatelessWidget {
  const Chat ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Chat",
          style: Theme.of(context).textTheme.headline1,
        ),
        const Icon(
          IconlyLight.chat,
          size: 40,
        ),
      ],
    );
  }
}