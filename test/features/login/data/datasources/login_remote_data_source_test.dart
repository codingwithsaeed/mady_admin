import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/datasources/login_remote_datasource.dart';
import 'package:mady_admin/features/login/data/models/admin_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'login_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late LoginRemoteDataSourceImpl dataSource;
  late MockClient client;

  setUp(() {
    client = MockClient();
    dataSource = LoginRemoteDataSourceImpl(client: client);
  });

  group('Remote Data', () {
    Params tParams = const Params(
      {'username': 'saeed', 'password': 'saeed', 'action': 'signin'},
    );

    AdminModel tAdminModel = AdminModel.fromJson(
      jsonDecode(
        fixture('success_login.json'),
      ),
    );
    test(
      "Should perform a post request with proper params.",
      () async {
        //arrange
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('success_login.json'), 200));
        //act
        final result = await dataSource.authenticate(tParams);
        //assert
        verify(client.post(
            Uri.parse('http://192.168.1.2/mady/webservice_admin.php'),
            body: tParams.param));
      },
    );

    test(
      "Should return [AdminModel] when request is successfull 200",
      () async {
        //arrange
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('success_login.json'), 200));
        //act
        final result = await dataSource.authenticate(tParams);
        //assert
        expect(result, tAdminModel);
      },
    );

    test(
      "Should throws [ServerException] when user not found",
      () async {
        //arrange
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('failed_login.json'), 200));
        //act
        final call = dataSource.authenticate;
        //assert
        expect(call(tParams), throwsA(const TypeMatcher<ServerException>()));
      },
    );

    test(
      "Should throws [ServerException] when request is unsuccessfull",
      () async {
        //arrange
        when(client.post(any, body: anyNamed('body'))).thenAnswer(
            (_) async => http.Response(fixture('failed_login.json'), 404));
        //act
        final call = dataSource.authenticate;
        //assert
        expect(call(tParams), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
