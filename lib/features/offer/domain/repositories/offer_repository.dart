import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';

abstract class OfferRepository {
  Future<Either<Failure, List<CategoryOffer>>> getAllOffers(Params params);
}
