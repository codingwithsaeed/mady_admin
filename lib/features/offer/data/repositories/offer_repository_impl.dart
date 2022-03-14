// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/offer/data/datasources/offer_remote_source.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/features/offer/domain/repositories/offer_repository.dart';

@Injectable(as: OfferRepository)
class OfferRepositoryImpl implements OfferRepository {
  final OfferRemoteSource dataSource;
  final NetworkInfo networkInfo;

  OfferRepositoryImpl(this.dataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Offer>>> getAllOffers(Params params) async {
    try {
      if (!await networkInfo.isConnected)
        return Left(ServerFailure(message: noInternetConnection));
      final result =
          await dataSource.getAllOffers({'action': 'get_all_offers'});
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, BaseModel<String>>> addOffer(Params params) async {
    try {
      if (!await networkInfo.isConnected)
        return Left(ServerFailure(message: noInternetConnection));
      final result = await dataSource.addOffer(params.param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> uploadPicture(Params params) async {
    if (!await networkInfo.isConnected)
      return Left(ServerFailure(message: noInternetConnection));

    try {
      final result = await dataSource.uploadPicture(params.param);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
