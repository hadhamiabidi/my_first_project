import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final bool showBackButton;

  const MyAppBar({
    Key? key,
    required this.title,
    this.height = kToolbarHeight,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black, // Change the text color to black
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white, // Change the background color to a darker color
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
        padding: const EdgeInsets.all(8),
        splashRadius: 20,
        highlightColor: Colors.black.withOpacity(0.1),
        splashColor: Colors.black.withOpacity(0.2),
        iconSize: 24,
        color: Colors.black,
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      )
          : null,
      automaticallyImplyLeading: false,
      // Set to false to remove default back button.
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
