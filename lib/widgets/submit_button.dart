import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_styles.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const SubmitButton({Key? key, required this.label, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50.0,
      child: ElevatedButton (
        onPressed:onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // <-- Radius
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          child:  Text(
            label,
            textAlign: TextAlign.center,
            style: AppStyles.white16W4Style,
          ),
        ),
      ),
    );
  }
}