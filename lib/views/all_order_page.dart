import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class AllOrder  extends StatelessWidget {
  const AllOrder ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "All Order",
          style: Theme.of(context).textTheme.headline1,
        ),
        const Icon(
          IconlyLight.home,
          size: 40,
        ),
      ],
    );
  }
}