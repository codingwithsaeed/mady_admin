// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/splash/data/datasources/splash_datasource.dart';
import 'package:mady_admin/features/splash/domain/repositories/splash_repository.dart';

@Injectable(as: SplashRepository)
class SplashRepositoryImpl implements SplashRepository {
  final SplashDataSource dataSource;
  final NetworkInfo networkInfo;

  const SplashRepositoryImpl({
    required this.dataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, bool>> checkLogin() async {
    try {
      if (!await networkInfo.isConnected)
        return Left(ServerFailure(message: noInternetConnection));
      return Right(dataSource.checkIsUserLoggedIn()!);
    } on SharedException {
      return const Right(false);
    }
  }
}
