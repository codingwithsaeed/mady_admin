import 'package:flutter/material.dart';

void showSnackbar(BuildContext context,
    {required String message,
    Color? color = Colors.red,
    Color? textColor = Colors.white}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(fontFamily: 'Vazir', color: textColor),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: color,
    ),
  );
}
