import 'package:flutter/material.dart';

class FaTextField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  const FaTextField({
    required this.icon,
    required this.hint,
    this.onChanged,
    this.controller,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        autofocus: false,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          hintTextDirection: TextDirection.rtl,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
