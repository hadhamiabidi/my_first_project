import 'package:flutter/material.dart';

class AllOrdersPage extends StatelessWidget {
  const AllOrdersPage({Key? key})  : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "All Orders",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ],
          ),

        ),
      ),
    );
  }


}