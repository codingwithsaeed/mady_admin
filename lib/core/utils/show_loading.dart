import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<dynamic> showLoading(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.red.withOpacity(0.1),
          insetPadding: const EdgeInsets.all(0.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SpinKitThreeBounce(
              color: Colors.red.shade900,
              size: 50.0,
            ),
          ),
        );
      });
}
