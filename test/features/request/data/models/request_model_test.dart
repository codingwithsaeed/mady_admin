import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/features/request/data/models/request_model.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  List<Request> requests = [
    const Request(
        srid: "2",
        storeName: "2 عطر آویشن",
        phone: "+989136581815",
        category: "ATARI",
        address: "اصفهان - میدان سهروردی",
        website: "www.avishan.co",
        logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
        lat: "32",
        lng: "51",
        pocket: "1"),
    const Request(
        srid: "1",
        storeName: "عطر آویشن",
        phone: "+989136581814",
        category: "ATARI",
        address: "اصفهان - میدان انقلاب",
        website: "www.avishan.co",
        logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
        lat: "32",
        lng: "51",
        pocket: "1"),
  ];

  RequestModel successModel = RequestModel(success: 1, data: requests);
  RequestModel failedModel = const RequestModel(success: 0);

  group('Testing model', () {
    test(
      "Should return a solid object when everything is ok",
      () async {
        //arrange
        //act
        final Map<String, dynamic> json =
            jsonDecode(fixture('request_model.json'));
        final result = RequestModel.fromJson(json);
        //assert
        expect(result, successModel);
      },
    );

    test(
      "Should return a failedModel when everything isn't ok",
      () async {
        //arrange
        //act
        final Map<String, dynamic> json =
            jsonDecode(fixture('failed_login.json'));
        final result = RequestModel.fromJson(json);
        //assert
        expect(result, failedModel);
      },
    );
  });
}
