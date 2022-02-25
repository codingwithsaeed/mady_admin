import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/error/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';

abstract class LoginRepository {
  Future<Either<Failure, Admin>> doLogin(Params params);
}
