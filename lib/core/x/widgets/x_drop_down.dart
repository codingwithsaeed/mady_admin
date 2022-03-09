import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class XDropDown<T> extends StatelessWidget {
  const XDropDown(
      {Key? key,
      required this.hint,
      required this.value,
      required this.height,
      required this.items,
      required this.onChanged})
      : super(key: key);
  final String hint;
  final T? value;
  final double height;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField2<T>(
        value: value,
        hint: Text(hint),
        items: items,
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        isExpanded: true,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
        buttonHeight: height,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
