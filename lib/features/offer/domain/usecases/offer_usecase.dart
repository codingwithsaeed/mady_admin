import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';
import 'package:mady_admin/features/offer/domain/repositories/offer_repository.dart';

@injectable
class OfferUsecase {
  final OfferRepository repository;

  const OfferUsecase(this.repository);

  Future<Either<Failure, List<Offer>>> getAllOffers(
      Params params) async {
    return await repository.getAllOffers(params);
  }
}
