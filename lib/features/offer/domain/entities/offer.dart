import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  const Offer({
    required this.oid,
    required this.content,
    required this.date,
    required this.sTime,
    required this.eTime,
    required this.price,
    required this.percent,
    required this.currentPrice,
    required this.picture,
    required this.count,
    required this.sid,
    required this.storeName,
    required this.address,
    required this.website,
    required this.logo,
    required this.lat,
    required this.lng,
    this.distance,
  });

  final String oid;
  final String content;
  final String date;
  final String sTime;
  final String eTime;
  final String price;
  final String percent;
  final String currentPrice;
  final String picture;
  final String count;
  final String sid;
  final String storeName;
  final String address;
  final String website;
  final String logo;
  final String lat;
  final String lng;
  final String? distance;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        date: json["date"],
        eTime: json["eTime"],
        oid: json["oid"],
        content: json["content"],
        sTime: json["sTime"],
        price: json["price"],
        percent: json["percent"],
        currentPrice: json["currentPrice"],
        picture: json["picture"],
        count: json["count"],
        sid: json["sid"],
        storeName: json["storeName"],
        address: json["address"],
        website: json["website"],
        logo: json["logo"],
        lat: json["lat"],
        lng: json["lng"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "eTime": eTime,
        "oid": oid,
        "content": content,
        "sTime": sTime,
        "price": price,
        "percent": percent,
        "currentPrice": currentPrice,
        "picture": picture,
        "count": count,
        "sid": sid,
        "storeName": storeName,
        "address": address,
        "website": website,
        "logo": logo,
        "lat": lat,
        "lng": lng,
        "distance": distance,
      };

  @override
  List<Object?> get props => [
        oid,
        content,
        date,
        sTime,
        eTime,
        price,
        percent,
        currentPrice,
        picture,
        count,
        sid,
        storeName,
        address,
        website,
        logo,
        lat,
        lng,
        distance
      ];
}
