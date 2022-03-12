import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/features/splash/domain/repositories/splash_repository.dart';

class SplashUsecase {
  final SplashRepository repository;

  SplashUsecase(this.repository);

  Future<Either<Failure, bool>> checkIsLoggedIn() async {
    return await repository.checkLogin();
  }
}
