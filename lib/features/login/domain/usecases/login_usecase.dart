import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/error/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';
import 'package:mady_admin/features/login/domain/repositories/login_repository.dart';

class LoginUsecase implements Usecase<Admin, Params> {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, Admin>> call(Params params) async {
    return await repository.doLogin(params);
  }
}
