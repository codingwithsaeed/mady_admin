import 'dart:convert';

import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/models/admin_model.dart';
import 'package:http/http.dart' as http;

abstract class LoginRemoteDataSource {
  /// Calls the http://192.168.1.2/mady/webservice_admin.php.
  /// Throws a [ServerException] for all error codes.
  Future<AdminModel> authenticate(Params params);
}

final url = Uri.parse('http://192.168.1.2/mady/webservice_admin.php');

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<AdminModel> authenticate(Params params) async {
    final result = await client.post(url, body: params);
    if (result.statusCode == 200) {
      AdminModel model = AdminModel.fromJson(jsonDecode(result.body));
      if (model.success == 1) {
        return model;
      } else {
        throw ServerException(message: NOT_FOUND_EX);
      }
    } else {
      throw ServerException(message: 'error code: ${result.statusCode}');
    }
  }
}
