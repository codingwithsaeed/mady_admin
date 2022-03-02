import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/features/request/data/datasources/request_remote_datasource.dart';
import 'package:mady_admin/features/request/data/models/request_model.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'request_remote_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late RequestRemoteSourceImpl sut;
  late MockClient client;

  setUp(() {
    client = MockClient();
    sut = RequestRemoteSourceImpl(client: client);
  });

  group('Remote Data', () {
    RequestModel tRequestModel = RequestModel.fromJson(
      jsonDecode(
        fixture('request_model.json'),
      ),
    );
    test(
      "Should perform a post request with proper params.",
      () async {
        //arrange
        when(client.post(any)).thenAnswer(
            (_) async => http.Response(fixture('request_model.json'), 200));
        //act
        sut.getRequests();
        //assert
        verify(
          client.post(
            Uri.parse('http://192.168.1.2/mady/webservice_admin.php'),
          ),
        );
      },
    );

    test(
      "Should return [RequestModel] when request is successfull 200",
      () async {
        //arrange
        when(client.post(any)).thenAnswer(
            (_) async => http.Response(fixture('request_model.json'), 200));
        //act
        final result = await sut.getRequests();
        //assert
        expect(result, tRequestModel);
      },
    );

    test(
      "Should throws [ServerException] when request is unsuccessfull",
      () async {
        //arrange
        when(client.post(any)).thenAnswer(
            (_) async => http.Response(fixture('failed_login.json'), 404));
        //act
        final call = sut.getRequests;
        //assert
        expect(call(), throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
