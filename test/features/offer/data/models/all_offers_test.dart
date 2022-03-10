import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('Testing offer fromJSon', () {
    const AllOffers offers = AllOffers(
        special:  CategoryOffer(
            name: "\u0648\u06cc\u0698\u0647", success: 0, data: []),
        tarebar:  CategoryOffer(
            name: "\u062a\u0631\u0647 \u0628\u0627\u0631",
            success: 0,
            data: []),
        flower:  CategoryOffer(
            name: "\u06af\u0644 \u0641\u0631\u0648\u0634\u06cc",
            success: 0,
            data: []),
        restaurant:  CategoryOffer(
            name:
                "\u0631\u0633\u062a\u0648\u0631\u0627\u0646 \u0648 \u0641\u0633\u062a\u0641\u0648\u062f",
            success: 0,
            data: []),
        fantezi:  CategoryOffer(
            name: "\u0646u0627\u0646 \u0641\u0627\u0646\u062a\u0632\u06cc",
            success: 0,
            data: []),
        market:  CategoryOffer(
            name: "\u0633\u0648\u067e\u0631\u0645\u0627\u0631\u06a9\u062a",
            success: 0,
            data: []),
        ganadi:  CategoryOffer(
            name: "\u0642\u0646\u0627\u062f\u06cc", success: 0, data: []),
        labaniat:  CategoryOffer(
            name: "\u0644\u0628\u0646\u06cc\u0627\u062a", success: 0, data: []),
        atari:  CategoryOffer(
            name: "\u0639\u0637\u0627\u0631\u06cc", success: 0, data: []),
        kharobar:  CategoryOffer(
            name: "\u062e\u0627\u0631\u0648\u0628\u0627\u0631",
            success: 0,
            data: []),
        gosht:  CategoryOffer(
            name: "\u0633\u0648\u067e\u0631\u06af\u0648\u0634\u062a",
            success: 1,
            data: [
              Offer(
                  date: "1400-12-19",
                  eTime: "22:00",
                  oid: "1",
                  content:
                      "\u06af\u0648\u0634\u062a \u0628\u0648\u0642\u0644\u0645\u0648\u0646",
                  sTime: "10:30",
                  price: "70000",
                  percent: "50",
                  currentPrice: "35000",
                  picture:
                      "http://192.168.1.2/mady/uploads/offerpics/meat.jpeg",
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
                  distance: "1.53")
            ]),
        arayeshi: CategoryOffer(
            name:
                "\u0644\u0648\u0627\u0632\u0645 \u0622\u0631\u0627\u06cc\u0634\u06cc",
            success: 0,
            data: []));

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
