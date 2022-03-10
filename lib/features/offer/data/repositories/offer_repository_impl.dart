// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/exceptions.dart';
import 'package:mady_admin/core/network/network_info.dart';
import 'package:mady_admin/features/login/data/repositories/login_repository_impl.dart';
import 'package:mady_admin/features/offer/data/datasources/offer_remote_source.dart';
import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';
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
  Future<Either<Failure, List<CategoryOffer>>> getAllOffers(
      Params params) async {
    try {
      if (!await networkInfo.isConnected)
        return Left(ServerFailure(message: NO_INTERNET_CONNECTION));
      final result = await dataSource.getAllOffers({'action': 'get_all_offers'});
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
