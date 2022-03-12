import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<dynamic> showLoading(BuildContext context) => showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(0.0),
        backgroundColor: Colors.white.withOpacity(0.8),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          width: MediaQuery.of(context).size.width,
          child: const SpinKitThreeBounce(
            color: Colors.red,
            size: 50.0,
          ),
        ),
      ),
    );
