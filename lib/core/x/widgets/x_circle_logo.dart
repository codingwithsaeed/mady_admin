import 'package:flutter/material.dart';

class XCircleLogo extends StatelessWidget {
  const XCircleLogo({Key? key, required this.logo, this.radius})
      : super(key: key);

  final String logo;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius ?? 80.0,
          backgroundImage: NetworkImage(logo),
        ),
      ],
      alignment: AlignmentDirectional.center,
    );
  }
}
