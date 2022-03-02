import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

class SingleSellerPage extends StatelessWidget {
  final int sellerId;
  const SingleSellerPage({
    Key? key,
    @PathParam() required this.sellerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SingleSellerPage'),
      ),
    );
  }
}
