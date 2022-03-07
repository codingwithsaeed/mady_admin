import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mady_admin/features/seller/domain/repositories/seller_repository.dart';

class SellerUsecase implements Usecase<List<Seller>, Params> {
  final SellerRepository repository;

  SellerUsecase(this.repository);

  @override
  Future<Either<Failure, List<Seller>>> call(Params params) async =>
      await repository.getSellers(params);
}