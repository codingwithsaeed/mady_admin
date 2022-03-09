import 'package:flutter/material.dart';

class XCircleLogo extends StatelessWidget {
  const XCircleLogo({
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
