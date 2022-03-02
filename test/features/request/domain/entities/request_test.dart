import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  Request tRequest = Request(
      srid: "1",
      storeName: "عطر آویشن",
      phone: "+989136581814",
      category: "ATARI",
      address: "اصفهان - میدان انقلاب",
      website: "www.avishan.co",
      logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
      lat: "32",
      lng: "51",
      pocket: "1");

  test(
    "FromJson testing",
    () async {
      final Map<String, dynamic> json = jsonDecode(fixture('request.json'));
      final result = Request.fromJson(json);
      expect(result, tRequest);
    },
  );
}
