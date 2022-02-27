import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/features/login/data/models/admin_model.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  Admin admin = const Admin('1', 'saeed');
  AdminModel modelSuccess = AdminModel(success: 1, data: admin);
  AdminModel modelFailed = const AdminModel(success: 0);

  test(
    "should return modelSuccess when auth is success",
    () async {
      final Map<String, dynamic> json =
          jsonDecode(fixture('success_login.json'));
      final result = AdminModel.fromJson(json);
      expect(result, modelSuccess);
    },
  );

  test(
    "should return modelSuccessl when auth is failed",
    () async {
      final Map<String, dynamic> json =
          jsonDecode(fixture('failed_login.json'));
      final result = AdminModel.fromJson(json);
      expect(result, modelFailed);
    },
  );

  test(
    "should return a jsonMap conain the proper data",
    () async {
      final result = modelSuccess.toJson();
      final expectedMap = jsonDecode(fixture('success_login.json'));
      expect(result, expectedMap);
    },
  );
}
