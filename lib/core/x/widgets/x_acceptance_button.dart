import 'package:flutter/material.dart';

class XAcceptanceButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPressed;
  const XAcceptanceButton(
      {Key? key,
      required this.color,
      required this.onPressed,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          padding: const EdgeInsets.symmetric(vertical: 10),
          onPressed: onPressed,
          color: color,
          child: Text(
            title,
            style: const TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
        ),
      ),
    );
  }
}