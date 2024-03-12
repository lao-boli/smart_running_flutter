import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppFormDropdown<T> extends StatefulWidget {
  final List<T> list;
  final String? hintText;
  final double? width;
  final T? model;
  final String Function(dynamic)? label;

  final void Function(dynamic)? onSave;

  const AppFormDropdown(
      {super.key,
      required this.list,
      this.hintText,
      this.width,
      this.model,
      this.onSave, this.label});

  @override
  State<AppFormDropdown> createState() => _AppDropdownMenuState<T>();
}

class _AppDropdownMenuState<T> extends State<AppFormDropdown> {
  String dropdownValue = '';
  String hintText = '';
  double? width;
  T? model;

  @override
  void initState() {
    super.initState();
    // dropdownValue = widget.list.first;
    hintText = widget.hintText!;
    width = widget.width;
    model = widget.model;
  }

  void _onDropDownItemSelected(T selectModel) {
    setState(() {
      print(selectModel);
      model = selectModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      onSaved: (e) => {
        widget.onSave?.call(model),
      },
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 10, 20, 20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              hint: Text(
                hintText,
              ),
              items: widget.list.map<DropdownMenuItem<T>>((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(widget.label != null ? widget.label!(value) : value as String),
                );
              }).toList(),
              isExpanded: true,
              isDense: true,
              onChanged: (newSelected) {
                _onDropDownItemSelected(newSelected as T);
              },
              value: model,
            ),
          ),
        );
      },
    );
  }
}
