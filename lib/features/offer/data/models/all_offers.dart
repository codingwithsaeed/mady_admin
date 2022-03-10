import 'package:equatable/equatable.dart';
import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';

class AllOffers extends Equatable {
  final List<CategoryOffer> offers;

  const AllOffers({required this.offers});

  factory AllOffers.fromJson(Map<String, dynamic> json) => AllOffers(
        offers: List<CategoryOffer>.from(
            json["offers"].map((x) => CategoryOffer.fromJson(x))),
      );

  @override
  List<Object?> get props => [offers];
}
