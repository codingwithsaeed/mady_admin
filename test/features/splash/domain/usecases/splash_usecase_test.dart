import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/splash/domain/repositories/splash_repository.dart';
import 'package:mady_admin/features/splash/domain/usecases/splash_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_usecase_test.mocks.dart';

@GenerateMocks([SplashRepository])
void main() {
  late SplashUsecase sut;
  late MockSplashRepository repository;

  setUp(() {
    repository = MockSplashRepository();
    sut = SplashUsecase(repository);
  });

  group('Check is LoggedIn', () {
    test(
      "should return a failure object if repository return it",
      () async {
        //arrange
        when(repository.checkLogin()).thenAnswer(
            (_) async => Left(ServerFailure(message: noInternetConnection)));
        //act
        final result = await sut.checkIsLoggedIn();
        //assert
        expect(result, Left(ServerFailure(message: noInternetConnection)));
      },
    );

    test(
      "should return a true if user logged in",
      () async {
        //arrange
        when(repository.checkLogin())
            .thenAnswer((_) async => const Right(true));
        //act
        final result = await sut.checkIsLoggedIn();
        //assert
        expect(result, const Right(true));
      },
    );
  });
}
