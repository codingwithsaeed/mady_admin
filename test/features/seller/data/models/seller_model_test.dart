import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/features/seller/data/models/seller_model.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('From JSon', () {
    final tSellersList = [
      Seller(
          sid: "2",
          storeName: "2 عطر آویشن",
          phone: "+989136581815",
          category: "ATARI",
          address: "اصفهان - میدان سهروردی",
          website: "www.avishan.co",
          logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
          lat: "32.646472",
          lng: "51.667644",
          pocket: "1",
          offerCount: "3",
          expire: "1400-12-23",
          hasSpecial: "0",
          specialCount: "0"),
      Seller(
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
          specialCount: "0")
    ];

    final tSellerModel1 = SellerModel(success: 1, data: tSellersList);
    const tSellerModel2 = SellerModel(success: 1, data: []);

    test(
      "should return a valid [SellerModel] obj if data isn't empty",
      () async {
        //arrange
        final json = jsonDecode(fixture('get_sellers.json'));
        //act
        final result = SellerModel.fromJson(json);
        //assert
        expect(result, tSellerModel1);
      },
    );

    test(
      "should return a valid [SellerModel] obj if data is empty",
      () async {
        //arrange
        final json = jsonDecode(fixture('get_sellers_empty.json'));
        //act
        final result = SellerModel.fromJson(json);
        //assert
        expect(result, tSellerModel2);
      },
    );
  });
}
