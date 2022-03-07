import 'package:mady_admin/core/usecases/usecase.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';

abstract class SellerRemoteSource {
  ///Performs a POST request to [http://192.168.1.2/mady/webservice_admin.php]
  ///Throws a [ServerException] on all error codes
  Future<List<Seller>> getSellers(Map<String, dynamic> params);
}
