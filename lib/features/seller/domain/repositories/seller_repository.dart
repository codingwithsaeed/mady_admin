import 'package:dartz/dartz.dart';
import 'package:mady_admin/core/errors/failures.dart';
import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/seller/domain/entities/add_seller.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';

abstract class SellerRepository {
  Future<Either<Failure, List<Seller>>> getSellers(Params params);
  Future<Either<Failure, bool>> insertSeller(AddSeller params);
  Future<Either<Failure, String>> uploadLogo(Params params);
}
