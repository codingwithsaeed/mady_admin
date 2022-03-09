import 'package:flutter/material.dart';

class XLableTextField extends StatelessWidget {
  final String lable;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? isMultiline;
  const XLableTextField({
    required this.lable,
    this.icon,
    this.onChanged,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.isMultiline = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        minLines: 1,
        maxLines: isMultiline! ? 3 : 1,
        textAlign: TextAlign.right,
        autofocus: false,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: lable,
          floatingLabelStyle: const TextStyle(fontSize: 18.0),
          alignLabelWithHint: true,
          suffixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
