import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/domain/repositories/request_repository.dart';

@injectable
class RequestUsecase {
  final RequestRepository repository;

  RequestUsecase(this.repository);

  Future<Either<Failure, List<Request>>> getRequests() async {
    return await repository.getRequests();
  }

    Future<Either<Failure, bool>> verifyRequest(Params params) async {
    return await repository.verifyRequest(params);
  }
}
