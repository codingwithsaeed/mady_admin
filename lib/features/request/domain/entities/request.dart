import 'package:equatable/equatable.dart';

class Request extends Equatable {
  Request({
    required this.srid,
    required this.storeName,
    required this.phone,
    required this.category,
    required this.address,
    required this.website,
    required this.logo,
    required this.lat,
    required this.lng,
    required this.pocket,
  });

  String srid;
  String storeName;
  String phone;
  String category;
  String address;
  String website;
  String logo;
  String lat;
  String lng;
  String pocket;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        srid: json["srid"],
        storeName: json["storeName"],
        phone: json["phone"],
        category: json["category"],
        address: json["address"],
        website: json["website"],
        logo: json["logo"],
        lat: json["lat"],
        lng: json["lng"],
        pocket: json["pocket"],
      );

  Map<String, dynamic> toJson() => {
        "srid": srid,
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
        srid,
        storeName,
        phone,
        category,
        address,
        website,
        logo,
        lat,
        lng,
        pocket
      ];
}
