import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/request/domain/repositories/request_repository.dart';

@injectable
class VerifyRequestUsecase implements Usecase<bool, Params> {
  final RequestRepository repository;

  VerifyRequestUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return repository.verifyRequest(params);
  }
}
