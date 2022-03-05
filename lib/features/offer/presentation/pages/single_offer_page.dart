import 'package:flutter/material.dart';

class SingleOfferPage extends StatelessWidget {
  final int offerId;
  const SingleOfferPage({
    Key? key,
    required this.offerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('SingleOfferPage $offerId'),
      ),
    );
  }
}
