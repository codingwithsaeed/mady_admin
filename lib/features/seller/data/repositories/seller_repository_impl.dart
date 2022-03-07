// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/seller/data/datasources/seller_remote_source.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/features/seller/domain/repositories/seller_repository.dart';

@Injectable(as: SellerRepository)
class SellerRepositoryImpl implements SellerRepository {
  final SellerRemoteSource dataSource;
  final NetworkInfo networkInfo;

  SellerRepositoryImpl({required this.dataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<Seller>>> getSellers(Params params) async {
    if (!await networkInfo.isConnected)
      return Left(ServerFailure(message: NO_INTERNET_CONNECTION));

    try {
      final result = await dataSource.getSellers(params.param);
      return Right(result.data!);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
