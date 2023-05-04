import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe/controllers/dashboard_controller.dart';

import '../config/app_styles.dart';
import '../widgets/dashboard_item.dart';

class DashboardPage extends StatelessWidget {
  final _controller = DashboardController();
  DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome !!!",style:AppStyles.black18W6Style,),
                        const SizedBox(height: 8), // Add some spacing between the texts
                        Obx(() => Text(_controller.displayName.value,style:AppStyles.black14W7Style,)),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                 /* const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('images/photos.jpg'),
                  ),*/
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                children: [
                  MyMenu(title: "Visualization of the list of orders",icon: Icons.list, warna: Colors.brown, onPressed: () { _controller.goToPage(1); },),
                  MyMenu(title: "Visualization of statistics",icon: Icons.stacked_line_chart, warna: Colors.red, onPressed: () {  },),
                  MyMenu(title: "Real-time order status tracking",icon: Icons.search, warna: Colors.pink, onPressed: () {  },),
                  MyMenu(title: "Claim",icon: Icons.not_interested_outlined, warna: Colors.blue, onPressed: () {  _controller.goToPage(4); },),
                  MyMenu(title: "Chat with delivery man",icon: Icons.chat, warna: Colors.grey, onPressed: () { _controller.goToPage(5); },),
                  MyMenu(title: "Delivery manager contact",icon: Icons.contact_phone_outlined, warna: Colors.green, onPressed: () {  },),
                ],
              ),
            ),
          ],
        ),
      ),
      );
  }
}
