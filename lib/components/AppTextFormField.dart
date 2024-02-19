import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String labelText;
  final String? suffixText;
  final String? permanentSuffixText;
  final int? maxLines;

  const AppTextFormField({super.key, required this.labelText, this.suffixText, this.permanentSuffixText, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: permanentSuffixText != null ? Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(permanentSuffixText!, style: TextStyle(color: Colors.grey)),
          ) : null,
          labelText: labelText,
          alignLabelWithHint: true
        ),
        maxLines: maxLines,

      ),
    );
  }
}
