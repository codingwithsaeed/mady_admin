import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';
import 'package:mady_admin/features/offer/domain/repositories/offer_repository.dart';

class OfferUsecase {
  final OfferRepository repository;

  const OfferUsecase(this.repository);

  Future<Either<Failure, List<CategoryOffer>>> getAllOffers(
      Params params) async {
    return await repository.getAllOffers(params);
  }
}
