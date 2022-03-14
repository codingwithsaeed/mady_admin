import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/features/offer/domain/entities/add_offer.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('Testing offer fromJSon', () {
    const tOffer = Offer(
        date: "1400-12-19",
        eTime: "22:00",
        oid: "1",
        content:
            "\u06af\u0648\u0634\u062a \u0628\u0648\u0642\u0644\u0645\u0648\u0646",
        sTime: "10:30",
        price: "70000",
        percent: "50",
        currentPrice: "35000",
        picture: "http://192.168.1.2/mady/uploads/offerpics/meat.jpeg",
        count: "10",
        sid: "8",
        storeName:
            "\u0633\u0648\u067e\u0631\u06af\u0648\u0634\u062a \u0633\u0639\u06cc\u062f ",
        address:
            "\u0627\u0635\u0641\u0647\u0627\u0646 \u0645\u06cc\u062f\u0627\u0646 \u0627\u0645\u0627\u0645 ",
        website: "https://codingwithsaeed.ir",
        logo: "http://192.168.1.2/mady/uploads/logo/yzFtDk.jpeg",
        lat: "32.66759720557876",
        lng: "51.68581299483777",
        distance: "1.53");

    test(
      "Should return a solid offer object",
      () async {
        //arrange
        final json = fixture('offer.json');
        //act
        final result = Offer.fromJson(jsonDecode(json));
        //assert
        expect(result, tOffer);
      },
    );
  });

  group('Testing AddOffer toJSon', () {
    final tOffer = AddOffer(
      sellerPhone: "09136581814",
      content: "بسته ده تایی گوشت بوقلمون",
      date: "1400-12-23",
      sTime: "14:00",
      eTime: "23:59",
      price: "30000",
      percent: "50",
      currentPrice: "15000",
      picture: "http://192.168.1.2/mady/uploads/offerpics/meat.jpeg",
      count: "20",
      isSpecial: "1",
      status: "0",
    );

    test(
      "Should return a solid offer object",
      () async {
        //act
        final result = tOffer.toJson();
        //assert
        expect(result, {
          "action": "insert_offer",
          "sellerPhone": "09136581814",
          "content": "بسته ده تایی گوشت بوقلمون",
          "date": "1400-12-23",
          "sTime": "14:00",
          "eTime": "23:59",
          "price": "30000",
          "percent": "50",
          "currentPrice": "15000",
          "picture": "http://192.168.1.2/mady/uploads/offerpics/meat.jpeg",
          "count": "20",
          "isSpecial": "1",
          "status": "0",
        });
      },
    );
  });
}
