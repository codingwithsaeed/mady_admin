import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/request/data/datasources/request_remote_datasource.dart';
import 'package:mady_admin/features/request/data/models/request_model.dart';
import 'package:mady_admin/features/request/data/repositories/request_repository_impl.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'request_repository_impl_test.mocks.dart';

@GenerateMocks([RequestRemoteSource, NetworkInfo])
void main() {
  late RequestRepositoryImpl sut;
  late MockRequestRemoteSource remoteSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    remoteSource = MockRequestRemoteSource();
    networkInfo = MockNetworkInfo();
    sut = RequestRepositoryImpl(
        dataSource: remoteSource, networkInfo: networkInfo);
  });

  group('GetRequests Test', () {
    List<Request> requests = [
      Request(
          srid: "2",
          storeName: "2 عطر آویشن",
          phone: "+989136581815",
          category: "ATARI",
          address: "اصفهان - میدان سهروردی",
          website: "www.avishan.co",
          logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
          lat: "32",
          lng: "51",
          pocket: "1"),
      Request(
          srid: "1",
          storeName: "عطر آویشن",
          phone: "+989136581814",
          category: "ATARI",
          address: "اصفهان - میدان انقلاب",
          website: "www.avishan.co",
          logo: "http://192.168.1.2/mady/uploads/logo/avish.jpg",
          lat: "32",
          lng: "51",
          pocket: "1"),
    ];

    RequestModel successModel = RequestModel(success: 1, data: requests);
    RequestModel failedModel = const RequestModel(success: 0);
    test(
      "Should return [ServerFailure] when device is offline",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        //act
        final result = await sut.getRequests();
        //assert
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
        verify(networkInfo.isConnected);
        verifyNoMoreInteractions(networkInfo);
      },
    );

    test(
      "Should return [ReguestModel] when device is online and request comeback from datasource",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteSource.getRequests()).thenAnswer((_) async => successModel);
        //act
        final result = await sut.getRequests();
        //assert
        expect(result, Right(successModel.data));
        verify(remoteSource.getRequests());
        verifyNoMoreInteractions(remoteSource);
      },
    );

    test(
      "Should return [ServerFailure] when catching ServerExcpetion from datasource",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteSource.getRequests())
            .thenThrow(ServerException(message: NOT_FOUND_EX));
        //act
        final result = await sut.getRequests();
        //assert
        expect(result, Left(ServerFailure(message: NOT_FOUND_EX)));
      },
    );
  });

  group('VerifyRequest test', () {
    const tParams = Params({'action': 'accept_seller', 'srid': '7'});
    test(
      'Should return [ServerFailure] if device isn\'t connected to internet',
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        //act
        final result = await sut.verifyRequest(tParams);
        //assert
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
        verify(networkInfo.isConnected);
        verifyNoMoreInteractions(networkInfo);
      },
    );

    test(
      'Should return [Right(true)] if operation is succeeded',
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteSource.verifyRequest(any)).thenAnswer((_) async => true);
        //act
        final result = await sut.verifyRequest(tParams);
        //assert
        expect(result, const Right(true));
        verify(remoteSource.verifyRequest(tParams.param));
        verifyNoMoreInteractions(remoteSource);
      },
    );

    test(
      'Should return [Left(ServerFailure)] when operation is unsucceeded',
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteSource.verifyRequest(any)).thenAnswer((_) async => false);
        //act
        final result = await sut.verifyRequest(tParams);
        //assert
        expect(result, Left(ServerFailure(message: NOT_FOUND_EX)));
      },
    );

    test(
      'Should return [Left(ServerFailure)] on DataSource Exceptions',
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(remoteSource.verifyRequest(any))
            .thenThrow(ServerException(message: NOT_FOUND_EX));
        //act
        final result = await sut.verifyRequest(tParams);
        //assert
        expect(result, Left(ServerFailure(message: NOT_FOUND_EX)));
      },
    );
  });
}
