import 'package:flutter/material.dart';

class SingleRequestPage extends StatelessWidget {
  final int requestId;
  const SingleRequestPage({
    Key? key,
    required this.requestId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SingleRequestPage'),
      ),
    );
  }
}
