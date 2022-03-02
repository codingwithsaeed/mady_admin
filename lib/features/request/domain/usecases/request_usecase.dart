import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/domain/repositories/request_repository.dart';

class RequestUsecase implements Usecase<List<Request>, NoParams> {
  final RequestRepository repository;

  RequestUsecase(this.repository);

  @override
  Future<Either<Failure, List<Request>>> call(NoParams params) async {
    return await repository.getRequests();
  }
}
