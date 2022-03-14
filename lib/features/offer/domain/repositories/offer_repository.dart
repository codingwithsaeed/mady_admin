import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';

abstract class OfferRepository {
  Future<Either<Failure, List<Offer>>> getAllOffers(Params params);
  Future<Either<Failure, BaseModel<String>>> addOffer(Params params);
}