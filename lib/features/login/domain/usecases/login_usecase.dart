import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/error/failures.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';
import 'package:mady_admin/features/login/domain/repositories/login_repository.dart';

class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  Future<Either<Failure, Admin>> login(Map<String, dynamic> data) async {
    return await repository.doLogin(data);
  }
}
