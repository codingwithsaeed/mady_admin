// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/request/data/datasources/request_remote_datasource.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/features/request/domain/repositories/request_repository.dart';

@Injectable(as: RequestRepository)
class RequestRepositoryImpl implements RequestRepository {
  final RequestRemoteSource dataSource;
  final NetworkInfo networkInfo;

  RequestRepositoryImpl({required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Request>>> getRequests() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(ServerFailure(message: NO_INTERNET_CONNECTION));
      }
      final result = await dataSource.getRequests();
      return Right(result.data!);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on Exception {
      return Left(ServerFailure(message: 'مشکلی در اتصال به سرور وجود دارد'));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyRequest(Params params) async {
    try {
      if (!await networkInfo.isConnected)
        return Left(ServerFailure(message: NO_INTERNET_CONNECTION));
      final result = await dataSource.verifyRequest(params.param);
      if (result) return Right(result);
      return Left(ServerFailure(message: NOT_FOUND_EX));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
