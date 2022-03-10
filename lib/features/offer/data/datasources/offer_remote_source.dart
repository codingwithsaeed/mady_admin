// ignore_for_file: curly_braces_in_flow_control_structures
import 'dart:convert';
import 'package:http/http.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';

abstract class OfferRemoteSource {
  ///Performs a POST request to [http://192.168.1.2/mady/webservice.php]
  ///Throws a [ServerException] on all error codes
  Future<List<CategoryOffer>> getAllOffers(Map<String, dynamic> params);
}

final url = Uri.parse('http://192.168.1.2/mady/webservice.php');

class OfferRemoteSourceImpl implements OfferRemoteSource {
  final Client client;

  OfferRemoteSourceImpl({required this.client});

  @override
  Future<List<CategoryOffer>> getAllOffers(Map<String, dynamic> params) async {
    final result = await client.post(url, body: params);
    if (result.statusCode == 200)
      return AllOffers.fromJson(jsonDecode(result.body)).offers;
    throw ServerException(message: 'error code: ${result.statusCode}');
  }
}