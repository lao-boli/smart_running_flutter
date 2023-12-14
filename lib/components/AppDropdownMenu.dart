import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDropdownMenu extends StatefulWidget {
  final List<String> list;
  final String? hintText;
  final double? width;

  const AppDropdownMenu(
      {super.key, required this.list, this.hintText, this.width});

  @override
  State<AppDropdownMenu> createState() => _AppDropdownMenuState();
}

class _AppDropdownMenuState extends State<AppDropdownMenu> {
  String dropdownValue = '';
  String hintText = '';
  double? width;

  @override
  void initState() {
    super.initState();
    // dropdownValue = widget.list.first;
    hintText = widget.hintText!;
    width = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      // initialSelection: widget.list.first,
      width: width,
      hintText: hintText,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
