import 'package:injectable/injectable.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/seller/domain/entities/add_seller.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mady_admin/features/seller/domain/repositories/seller_repository.dart';

@injectable
class SellerUsecase {
  final SellerRepository repository;

  SellerUsecase(this.repository);

  Future<Either<Failure, List<Seller>>> getSellers(Params params) async =>
      await repository.getSellers(params);

  Future<Either<Failure, bool>> insertSeller(AddSeller params) async =>
      await repository.insertSeller(params);

  Future<Either<Failure, String>> uploadLogo(Params params) async =>
      await repository.uploadLogo(params);
}
