import 'package:flutter/material.dart';
import 'package:pfe/controllers/dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  final _controller = DashboardController();
  DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Menu"),
        backgroundColor: Colors.green[700],
      ),
      backgroundColor: Colors.green[100],
      body: Container(
        padding: EdgeInsets.all(30.0),

        child: GridView.count(
            crossAxisCount: 2,
          children: <Widget> [
            MyMenu(title: "Visualization of the list of orders",icon: Icons.list, warna: Colors.brown,),
            MyMenu(title: "Change in the status of the order",icon: Icons.published_with_changes, warna: Colors.purple,),
            MyMenu(title: "Visualization of statistics",icon: Icons.stacked_line_chart, warna: Colors.red,),
            MyMenu(title: "Real-time order status tracking",icon: Icons.search, warna: Colors.pink,),
            MyMenu(title: "Claim",icon: Icons.not_interested_outlined, warna: Colors.blue,),
            MyMenu(title: "Chat with delivery man",icon: Icons.chat, warna: Colors.grey,),
            MyMenu(title: "Delivery manager contact",icon: Icons.contact_phone_outlined, warna: Colors.green,),


          ],
        ),
      ),
      );
  }
}
class MyMenu extends StatelessWidget {
  MyMenu({required this.title, required this.icon, required this.warna});
  final String title;
  final IconData icon;
  final MaterialColor warna;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){},
        splashColor: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              Icon(
              icon,
                size: 70.0,
                color: warna,
              ),
              Text(title, style: new TextStyle(fontSize: 17.0))
            ],
          ),
        ),
      ),
    );



  }
}
