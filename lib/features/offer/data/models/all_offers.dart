import 'package:equatable/equatable.dart';
import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';

class AllOffers extends Equatable {
  final CategoryOffer special;
  final CategoryOffer tarebar;
  final CategoryOffer flower;
  final CategoryOffer restaurant;
  final CategoryOffer fantezi;
  final CategoryOffer market;
  final CategoryOffer ganadi;
  final CategoryOffer labaniat;
  final CategoryOffer atari;
  final CategoryOffer kharobar;
  final CategoryOffer gosht;
  final CategoryOffer arayeshi;

  const AllOffers(
      {required this.special,
      required this.tarebar,
      required this.flower,
      required this.restaurant,
      required this.fantezi,
      required this.market,
      required this.ganadi,
      required this.labaniat,
      required this.atari,
      required this.kharobar,
      required this.gosht,
      required this.arayeshi});

  factory AllOffers.fromJson(Map<String, dynamic> json) => AllOffers(
      special: CategoryOffer.fromJson(json['special']),
      tarebar: CategoryOffer.fromJson(json['tarebar']),
      flower: CategoryOffer.fromJson(json['flower']),
      restaurant: CategoryOffer.fromJson(json['restaurant']),
      fantezi: CategoryOffer.fromJson(json['fantezi']),
      market: CategoryOffer.fromJson(json['market']),
      ganadi: CategoryOffer.fromJson(json['ganadi']),
      labaniat: CategoryOffer.fromJson(json['labaniat']),
      atari: CategoryOffer.fromJson(json['atari']),
      kharobar: CategoryOffer.fromJson(json['kharobar']),
      gosht: CategoryOffer.fromJson(json['gosht']),
      arayeshi: CategoryOffer.fromJson(json['arayeshi']));

  @override
  List<Object?> get props => [
        special,
        tarebar,
        flower,
        restaurant,
        fantezi,
        market,
        ganadi,
        labaniat,
        atari,
        kharobar,
        gosht,
        arayeshi
      ];
}
