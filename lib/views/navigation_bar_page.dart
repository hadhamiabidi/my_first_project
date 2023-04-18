import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pfe/views/all_orders_page.dart';
import 'package:pfe/views/chat_page.dart';
import 'package:pfe/views/my_order_page.dart';
import 'package:pfe/views/profile_page.dart';

import '../controllers/bottom_navigation_controller.dart';


class NavigationPage extends StatelessWidget {

  BottomNavigationController bottomNavigationController =
  Get.put(BottomNavigationController());
  NavigationPage({Key? key})  : super(key: key);


  final screen = [
    ProfilePage(),
    ChatPage(),
    MyOrderPage(),
    AllOrdersPage(),
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

      bottomNavigationBar: Obx(() => BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          bottomNavigationController.changedIndex(index);
        },
        currentIndex: bottomNavigationController.selectedIndex.value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "All Orders",
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "My order",
            backgroundColor: Colors.purple,
          ),
        ],

      ),


      ),
    );
  }
}