import 'package:flutter/material.dart';
import 'package:pfe/controllers/dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  final _controller = DashboardController();
  DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("Dashboard"),
      ),
    );
  }
}
