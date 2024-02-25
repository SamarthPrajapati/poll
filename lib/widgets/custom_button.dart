import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Background color
        textStyle: TextStyle(color: Colors.white), // Text color
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Button padding
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Button border radius
      ),
    );
  }
}
