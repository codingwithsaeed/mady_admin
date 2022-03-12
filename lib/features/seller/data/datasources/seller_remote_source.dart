// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/features/seller/data/models/seller_model.dart';
import 'package:http/http.dart' as http;

abstract class SellerRemoteSource {
  ///Performs a POST request to [http://192.168.1.2/mady/webservice_admin.php]
  ///Throws a [ServerException] on all error codes
  Future<SellerModel> getSellers(Map<String, dynamic> params);

  ///Performs a POST request to [http://192.168.1.2/mady/webservice_admin.php]
  ///Throws a [ServerException] on all error codes
  Future<bool> insertSeller(Map<String, dynamic> params);

  ///Performs a POST request to [http://192.168.1.2/mady/webservice_admin.php]
  ///Throws a [ServerException] on all error codes
  Future<String> uploadLogo(Map<String, dynamic> params);
}

final url = Uri.parse('http://192.168.1.2/mady/webservice_admin.php');

@Injectable(as: SellerRemoteSource)
class SellerRemoteSourceImpl implements SellerRemoteSource {
  final http.Client client;

  SellerRemoteSourceImpl({required this.client});

  @override
  Future<SellerModel> getSellers(Map<String, dynamic> params) async {
    final res = await client.post(url, body: params);
    if (res.statusCode == 200)
      return SellerModel.fromJson(jsonDecode(res.body));
    throw ServerException(message: 'error code: ${res.statusCode}');
  }

  @override
  Future<bool> insertSeller(Map<String, dynamic> params) async {
    final result = await client.post(url,
        body: params, encoding: Encoding.getByName('utf8'));
    if (result.statusCode == 200) {
      if (jsonDecode(result.body)['success'] == 1)
        return true;
      else if (jsonDecode(result.body)['success'] == -1)
        throw ServerException(message: 'این شماره مربوط به فروشنده دیگری است');
      else
        throw ServerException(message: 'مشکلی در ثبت فروشنده پیش آمد.');
    }
    throw ServerException(message: 'error code: ${result.statusCode}');
  }

  @override
  Future<String> uploadLogo(Map<String, dynamic> params) async {
    final result = await client.post(url, body: params);
    if (result.statusCode == 200) {
      if (jsonDecode(result.body)['success'] == 1)
        return jsonDecode(result.body)['data'];
      else
        throw ServerException(message: 'مشکلی در آپلود لوگو پیش آمد.');
    }
    throw ServerException(message: 'error code: ${result.statusCode}');
  }
}
