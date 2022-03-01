import 'package:flutter/material.dart';

class NaterialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;
  const NaterialButton({
    required this.onPressed,
    required this.title,
    this.color = Colors.blue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        onPressed: onPressed,
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20.0),
        ),
        color: Colors.red,
        textColor: Colors.white,
      ),
    );
  }
}
