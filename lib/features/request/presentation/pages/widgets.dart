import 'package:flutter/material.dart';

class AcceptanceButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onPressed;
  const AcceptanceButton(
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

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.0),
      child: ListTile(
          title: Text(
            title,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          horizontalTitleGap: 10.0,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 3, horizontal: 15)),
    );
  }
}

class CircleLogo extends StatelessWidget {
  const CircleLogo({
    Key? key,
    required this.logo,
  }) : super(key: key);

  final String logo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 80.0,
          backgroundImage: NetworkImage(logo),
        ),
      ],
      alignment: AlignmentDirectional.center,
    );
  }
}
