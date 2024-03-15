import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String labelText;
  final String? suffixText;
  final String? permanentSuffixText;
  final ValueChanged<String>? onChanged;

  const AppTextField({super.key, required this.labelText, this.suffixText, this.permanentSuffixText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        onChanged: onChanged,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: permanentSuffixText != null ? Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(permanentSuffixText!, style: TextStyle(color: Colors.grey)),
          ) : null,
          labelText: labelText,

        ),
      ),
    );
  }
}
