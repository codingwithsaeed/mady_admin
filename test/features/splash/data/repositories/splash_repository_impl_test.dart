import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/splash/data/datasources/splash_datasource.dart';
import 'package:mady_admin/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_repository_impl_test.mocks.dart';

@GenerateMocks([SplashDataSource, NetworkInfo])
void main() {
  late MockSplashDataSource dataSource;
  late MockNetworkInfo networkInfo;
  late SplashRepositoryImpl sut;

  setUp(() {
    dataSource = MockSplashDataSource();
    networkInfo = MockNetworkInfo();
    sut =
        SplashRepositoryImpl(dataSource: dataSource, networkInfo: networkInfo);
  });

  group('Check is user loggedIn', () {
    test(
      "Should Reutrn [ServerFailure] if device is Offline",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => false);
        when(dataSource.checkIsUserLoggedIn()).thenAnswer((_) => true);
        //act
        final result = await sut.checkLogin();
        //assert
        expect(result, Left(ServerFailure(message: noInternetConnection)));
        verify(networkInfo.isConnected);
        verifyNoMoreInteractions(networkInfo);
      },
    );

    test(
      "Should Reutrn true if user is logged in",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.checkIsUserLoggedIn()).thenAnswer((_) => true);
        //act
        final result = await sut.checkLogin();
        //assert
        expect(result, const Right(true));
        verify(dataSource.checkIsUserLoggedIn());
        verifyNoMoreInteractions(dataSource);
      },
    );

    test(
      "Should Reutrn false if data source throws a [SharedException]",
      () async {
        //arrange
        when(networkInfo.isConnected).thenAnswer((_) async => true);
        when(dataSource.checkIsUserLoggedIn())
            .thenThrow(const SharedException(message: notFoundException));
        //act
        final result = await sut.checkLogin();
        //assert
        expect(result, const Right(false));
      },
    );
  });
}
