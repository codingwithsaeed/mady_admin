import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/datasources/login_remote_datasource.dart';
import 'package:mady_admin/features/login/data/models/admin_model.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSource, NetworkInfo])
void main() {
  late LoginRepositoryImpl repository;
  late MockLoginRemoteDataSource dataSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    networkInfo = MockNetworkInfo();
    dataSource = MockLoginRemoteDataSource();
    repository =
        LoginRepositoryImpl(dataSource: dataSource, networkInfo: networkInfo);
  });

  group('login repository', () {
    late Params params;
    late AdminModel model;
    late Admin admin;
    setUp(() {
      params = const Params({"username": "saeed", "password": "saeed"});
      admin = const Admin("1", "saeed");
      model = AdminModel(success: 1, data: admin);
    });
    test(
      "should return ServerFailure when device is offline",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        //act
        final result = await repository.authenticate(params);
        //assert
        expect(result, Left(ServerFailure(message: NO_INTERNET_CONNECTION)));
        verify(networkInfo.isConnected);
        verifyNoMoreInteractions(networkInfo);
      },
    );

    test(
      "Should return admin if device is online and remote data source return it",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.authenticate(any)).thenAnswer((_) async => model);
        //act
        final result = await repository.authenticate(params);
        //assert
        expect(result, Right(admin));
        verify(dataSource.authenticate(params));
        verifyNoMoreInteractions(dataSource);
      },
    );

    test(
      "Should return ServerFailure on ServerExceptions From dataSource",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.authenticate(any)).thenThrow(ServerException(message: NOT_FOUND_EX));
        //act
        final result = await repository.authenticate(params);
        //assert
        expect(result, Left(ServerFailure(message: NOT_FOUND_EX)));
        verify(dataSource.authenticate(params));
        verifyNoMoreInteractions(dataSource);
      },
    );
  });
}
