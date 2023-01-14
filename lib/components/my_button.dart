import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'SIGN UP',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

