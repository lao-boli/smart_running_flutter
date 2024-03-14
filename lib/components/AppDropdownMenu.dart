import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/pages/user/user_logic.dart';

class AppDropdownMenu<T> extends StatefulWidget {
  final String? hintText;
  final double? width;
  final String Function(dynamic)? label;
  final void Function(dynamic)? onClear;
  final List<T> Function() list;
  final ValueChanged<dynamic>? onSelected;

  const AppDropdownMenu(
      {super.key,
      required this.list,
      this.hintText,
      this.width,
      this.label,
      this.onSelected, this.onClear});

  @override
  State<AppDropdownMenu> createState() => _AppDropdownMenuState<T>();
}

class _AppDropdownMenuState<T> extends State<AppDropdownMenu> {
  T? model;
  String hintText = '';
  double? width;
  List<String> items = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // dropdownValue = widget.list.first;
    hintText = widget.hintText!;
    width = widget.width;
    debugPrint("${widget.list}");
  }


  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      controller: controller,
      trailingIcon: model == null
          ? const Icon(Icons.arrow_drop_down)
          : SizedBox(
              height: 20,
              width: 20,
              child: IconButton(
                padding: new EdgeInsets.only(bottom: 20),
                icon: Icon(
                  Icons.close,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    controller.text = '';
                    widget.onClear?.call(model);
                    model = null;
                  });
                },
              )),
      width: width,
      hintText: hintText,
      onSelected: (value) => {
        setState(() {
          model = value;
        }),
        widget.onSelected?.call(value)
      },
      dropdownMenuEntries:
          widget.list.call().map<DropdownMenuEntry<T>>((value) {
        return DropdownMenuEntry<T>(
            value: value, label: widget.label?.call(value) ?? value as String);
      }).toList(),
    );
  }
}
