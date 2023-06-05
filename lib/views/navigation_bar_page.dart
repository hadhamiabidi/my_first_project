import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe/views/all_orders_page.dart';
import 'package:pfe/views/chat_page.dart';
import 'package:pfe/views/conversation_page.dart';
import 'package:pfe/views/my_order_page.dart';
import 'package:pfe/views/profile_page.dart';
import '../controllers/bottom_navigation_controller.dart';

class NavigationPage extends StatelessWidget {
  BottomNavigationController bottomNavigationController =
  Get.put(BottomNavigationController());

  NavigationPage({Key? key}) : super(key: key);

  final screen = [
    AllOrdersPage(),
    MyOrderPage(),
    ConversationsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => IndexedStack(
          index: bottomNavigationController.selectedIndex.value,
          children: screen,
        ),
      ),
      bottomNavigationBar: Obx(
            () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 1,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.black,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              elevation: 1,
              onTap: (index) {
                bottomNavigationController.changedIndex(index);
              },
              currentIndex: bottomNavigationController.selectedIndex.value,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: "Orders",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  label: "My Orders",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message),
                  label: "Chat",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
