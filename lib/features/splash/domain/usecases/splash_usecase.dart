import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/features/splash/domain/repositories/splash_repository.dart';


@injectable
class SplashUsecase {
  final SplashRepository repository;

  SplashUsecase(this.repository);

  Future<Either<Failure, bool>> checkIsLoggedIn() async {
    return await repository.checkLogin();
  }
}
