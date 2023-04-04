import 'package:flutter/material.dart';
import 'package:pfe/config/app_styles.dart';

class MyMenu extends StatelessWidget {
  MyMenu({required this.title, required this.icon, required this.warna, required this.onPressed});

  final String title;
  final IconData icon;
  final MaterialColor warna;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(14.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.green,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  icon,
                  size: 70.0,
                  color: warna,
                ),
                const SizedBox(height: 10,),
                Text(title,textAlign: TextAlign.center, style: AppStyles.black14W5Style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}