// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/request/data/models/request_model.dart';
import 'package:http/http.dart' as http;
import 'package:mady_admin/features/request/domain/entities/request.dart';

abstract class RequestRemoteSource {
  /// Calls the http://192.168.1.2/mady/webservice_admin.php.
  /// Throws a [ServerException] for all error codes.
  Future<RequestModel> getRequests();

  /// Calls the http://192.168.1.2/mady/webservice_admin.php.
  /// Throws a [ServerException] for all error codes.
  Future<bool> verifyRequest(Map<String, dynamic> params);
}

final url = Uri.parse('http://192.168.1.2/mady/webservice_admin.php');

@Injectable(as: RequestRemoteSource)
class RequestRemoteSourceImpl implements RequestRemoteSource {
  final http.Client client;

  RequestRemoteSourceImpl({required this.client});
  @override
  Future<RequestModel> getRequests() async {
    final result =
        await client.post(url, body: {'action': 'get_seller_requests'});
    if (result.statusCode == 200) {
      RequestModel model = RequestModel.fromJson(jsonDecode(result.body));
      if (model.success == 1)
        return model;
      else if (model.success == 0)
        return RequestModel(success: model.success, data: const <Request>[]);
      else
        throw ServerException(message: NO_INTERNET_CONNECTION);
    } else {
      throw ServerException(message: 'error code: ${result.statusCode}');
    }
  }

  @override
  Future<bool> verifyRequest(Map<String, dynamic> params) async {
    final result = await client.post(url, body: params);
    if (result.statusCode == 200) {
      if (jsonDecode(result.body)['success'] == 1) return true;
      throw ServerException(message: NOT_FOUND_EX);
    }
    throw ServerException(message: '${result.statusCode}');
  }
}
