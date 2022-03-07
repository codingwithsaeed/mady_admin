import 'package:equatable/equatable.dart';

class Seller extends Equatable {
  const Seller({
    required this.sid,
    required this.storeName,
    required this.phone,
    required this.category,
    required this.address,
    required this.website,
    required this.logo,
    required this.lat,
    required this.lng,
    required this.pocket,
    required this.offerCount,
    required this.expire,
    required this.hasSpecial,
    required this.specialCount,
  });

  final String sid;
  final String storeName;
  final String phone;
  final String category;
  final String address;
  final String website;
  final String logo;
  final String lat;
  final String lng;
  final String pocket;
  final String offerCount;
  final String expire;
  final String hasSpecial;
  final String specialCount;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        sid: json["sid"],
        storeName: json["storeName"],
        phone: json["phone"],
        category: json["category"],
        address: json["address"],
        website: json["website"],
        logo: json["logo"],
        lat: json["lat"],
        lng: json["lng"],
        pocket: json["pocket"],
        offerCount: json["offerCount"],
        expire: json["expire"],
        hasSpecial: json["hasSpecial"],
        specialCount: json["specialCount"],
      );

  Map<String, dynamic> toJson() => {
        "sid": sid,
        "storeName": storeName,
        "phone": phone,
        "category": category,
        "address": address,
        "website": website,
        "logo": logo,
        "lat": lat,
        "lng": lng,
        "pocket": pocket,
        "offerCount": offerCount,
        "expire": expire,
        "hasSpecial": hasSpecial,
        "specialCount": specialCount,
      };

  @override
  List<Object?> get props => [
        sid,
        storeName,
        phone,
        category,
        address,
        website,
        logo,
        lat,
        lng,
        pocket,
        offerCount,
        expire,
        hasSpecial,
        specialCount
      ];
}
