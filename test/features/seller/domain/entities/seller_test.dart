import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('Testing Seller', () {
    final tSeller = Seller(
        sid: "1",
        storeName: "عطر آویشن",
        phone: "+989136581814",
        category: "ATARI",
        address: "اصفهان - میدان انقلاب",
        website: "www.avishan.co",
        logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
        lat: "32.646472",
        lng: "51.667644",
        pocket: "1",
        offerCount: "3",
        expire: "1400-12-22",
        hasSpecial: "0",
        specialCount: "0");

    test(
      "FromJson",
      () async {
        //arrange
        final Map<String, dynamic> json = jsonDecode(fixture('seller.json'));
        //act
        final result = Seller.fromJson(json);
        //assert
        expect(result, tSeller);
      },
    );
  });
}
