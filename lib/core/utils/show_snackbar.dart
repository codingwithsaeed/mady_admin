import 'package:flutter/material.dart';

void showSnackbar(
  BuildContext context, {
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontFamily: 'Vazir'),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: color ?? Colors.red,
    ),
  );
}
