import 'package:equatable/equatable.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';

class AllOffers extends Equatable {
  final List<Offer> offers;

  const AllOffers({required this.offers});

  factory AllOffers.fromJson(Map<String, dynamic> json) => AllOffers(
        offers: List<Offer>.from(
            json["offers"].map((x) => Offer.fromJson(x))),
      );

  @override
  List<Object?> get props => [offers];
}
