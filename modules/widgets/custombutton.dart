import 'package:flutter/material.dart';
import 'package:tophotels/modules/resources/app_colors.dart';

class CustomButton extends StatelessWidget {
  String title;
  final VoidCallback onTap;
  Color textColor;
  Color backgroundColor;
  Color borderSideColor;
  CustomButton({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.onTap,
    required this.textColor,
    required this.borderSideColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(color: borderSideColor),
      ),
      child: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
    );
  }
}
