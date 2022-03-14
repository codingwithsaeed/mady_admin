// ignore_for_file: curly_braces_in_flow_control_structures
import 'dart:convert';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/features/offer/data/models/all_offers.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';
import 'package:mady_admin/utils/consts.dart';

abstract class OfferRemoteSource {
  ///Performs a POST request to [https://codingwithsaeed.ir/api/mady/webservice_admin.php]
  ///Throws a [ServerException] on all error codes
  Future<List<Offer>> getAllOffers(Map<String, dynamic> params);

  ///Performs a POST request to [https://codingwithsaeed.ir/api/mady/webservice_admin.php]
  ///Throws a [ServerException] on all error codes
  Future<BaseModel<String>> addOffer(Map<String, dynamic> params);
}

@Injectable(as: OfferRemoteSource)
class OfferRemoteSourceImpl implements OfferRemoteSource {
  final Client client;

  OfferRemoteSourceImpl({required this.client});

  @override
  Future<List<Offer>> getAllOffers(Map<String, dynamic> params) async {
    final result = await client.post(Consts.currentUrl, body: params);
    if (result.statusCode == 200)
      return AllOffers.fromJson(jsonDecode(result.body)).offers;
    throw ServerException(message: 'error code: ${result.statusCode}');
  }

  @override
  Future<BaseModel<String>> addOffer(Map<String, dynamic> params) async {
    final result = await client.post(Consts.currentUrl, body: params);
    if (result.statusCode == 200) {
      int success = jsonDecode(result.body)['success'];
      switch (success) {
        case 1:
          return BaseModel<String>(success: success, data: '');
        case -1:
          throw ServerException(message: 'فروشنده ای با این شماره وجود ندارد');
        case -2:
          throw ServerException(message: jsonDecode(result.body)['error']);
      }
    }
    throw ServerException(message: 'error code: ${result.statusCode}');
  }
}
