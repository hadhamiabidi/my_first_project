import 'package:flutter/material.dart';
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
                        Text("Hadhami Abidi",style:AppStyles.black14W7Style,),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('images/photos.jpg'),
                  ),// Add some spacing between the two widgets
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                children: <Widget> [
                  MyMenu(title: "Visualization of the list of orders",icon: Icons.list, warna: Colors.brown, onPressed: () {  },),
                  MyMenu(title: "Visualization of statistics",icon: Icons.stacked_line_chart, warna: Colors.red, onPressed: () {  },),
                  MyMenu(title: "Real-time order status tracking",icon: Icons.search, warna: Colors.pink, onPressed: () {  },),
                  MyMenu(title: "Claim",icon: Icons.not_interested_outlined, warna: Colors.blue, onPressed: () {  },),
                  MyMenu(title: "Chat with delivery man",icon: Icons.chat, warna: Colors.grey, onPressed: () {  },),
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
