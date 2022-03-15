import 'package:flutter/material.dart';

class XButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final double? fontSize;
  const XButton({
    required this.onPressed,
    required this.title,
    this.color = Colors.blue,
    this.fontSize = 20.0,
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
          style: TextStyle(fontSize: fontSize),
        ),
        color: color,
        textColor: Colors.white,
      ),
    );
  }
}
