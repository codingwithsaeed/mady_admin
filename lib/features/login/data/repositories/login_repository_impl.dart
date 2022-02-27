import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/features/login/data/datasources/login_remote_datasource.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/features/login/domain/repositories/login_repository.dart';

const NO_INTERNET_CONNECTION = "No intenet connection";

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource dataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl({required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Admin>> authenticate(Params params) async {
    if (!await networkInfo.isConnected) {
      return Left(ServerFailure(message: NO_INTERNET_CONNECTION));
    }

    try {
      final adminModel = await dataSource.authenticate(params);
      return Right(adminModel.data!);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}