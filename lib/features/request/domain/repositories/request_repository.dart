import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';

abstract class RequestRepository {
  Future<Either<Failure, List<Request>>> getRequests();
}
