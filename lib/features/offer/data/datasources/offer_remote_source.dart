import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';

abstract class OfferRemoteSource {
  ///Performs a POST request to [http://192.168.1.2/mady/webservice.php]
  ///Throws a [ServerException] on all error codes
  Future<List<CategoryOffer>> getSellers(Map<String, dynamic> params);
}
