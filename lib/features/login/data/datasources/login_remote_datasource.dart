import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/models/admin_model.dart';
import 'package:http/http.dart' as http;
import 'package:mady_admin/utils/consts.dart';

abstract class LoginRemoteDataSource {
  /// Perform a POST request to [https://codingwithsaeed.ir/api/mady/webservice_admin.php]
  /// Throws a [ServerException] for all error codes.
  Future<AdminModel> authenticate(Params params);
}

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  @override
  Future<AdminModel> authenticate(Params params) async {
    final result =
        await client.post(Consts.currentUrl, body: params.param);
    if (result.statusCode == 200) {
      AdminModel model = AdminModel.fromJson(jsonDecode(result.body));
      if (model.success == 1) {
        return model;
      } else {
        throw ServerException(message: notFoundException);
      }
    } else {
      throw ServerException(message: 'error code: ${result.statusCode}');
    }
  }
}
