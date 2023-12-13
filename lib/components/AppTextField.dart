import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String labelText;

  const AppTextField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }
}
