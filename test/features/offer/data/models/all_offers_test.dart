import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('Testing offer fromJSon', () {
    final AllOffers offers = AllOffers.fromJson(jsonDecode(fixture('all_offers.json')));

    test(
      "Should return a solid offer object",
      () async {
        //arrange
        final json = fixture('all_offers.json');
        //act
        final result = AllOffers.fromJson(jsonDecode(json));
        //assert
        expect(result, offers);
      },
    );
  });
}
