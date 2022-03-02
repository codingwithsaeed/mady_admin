import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SingleOfferPage extends StatelessWidget {
  final int offerId;
  const SingleOfferPage({
    Key? key,
    @PathParam() required this.offerId,
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
