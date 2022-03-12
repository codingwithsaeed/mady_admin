import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/errors/failures.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> checkLogin();
}
