import 'package:equatable/equatable.dart';

class AddSeller extends Equatable {
  const AddSeller({
    required this.storeName,
    required this.phone,
    required this.category,
    required this.address,
    required this.logo,
    required this.lat,
    required this.lng,
    required this.pocket,
  });

  final String action = 'insert_seller';
  final String storeName;
  final String phone;
  final String category;
  final String address;
  final String website = 'https://codingwithsaeed.ir';
  final String logo;
  final String lat;
  final String lng;
  final String pocket;

  Map<String, dynamic> toJson() => {
        "action": action,
        "storeName": storeName,
        "phone": phone,
        "category": category,
        "address": address,
        "website": website,
        "logo": logo,
        "lat": lat,
        "lng": lng,
        "pocket": pocket,
      };

  @override
  List<Object?> get props => [
        storeName,
        phone,
        category,
        address,
        website,
        logo,
        lat,
        lng,
        pocket,
      ];
}
