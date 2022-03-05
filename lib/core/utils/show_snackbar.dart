import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontFamily: 'Vazir'),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
    ),
  );
}
