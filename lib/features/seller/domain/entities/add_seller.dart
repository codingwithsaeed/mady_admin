// ignore_for_file: must_be_immutable, curly_braces_in_flow_control_structures

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddSeller extends Equatable {
  AddSeller({
    this.storeName,
    this.phone,
    this.address,
    this.logo,
    this.lat,
    this.lng,
    this.pocket,
    this.category,
  });

  final String action = 'insert_seller';
  late String? storeName;
  late String? phone;
  late String? category;
  late String? address;
  late String website = 'https://codingwithsaeed.ir';
  late String? logo;
  late String? lat;
  late String? lng;
  late String? pocket;

  Either<String, bool> validate() {
    if (storeName == null)
      return const Left('نام فروشگاه را وارد کنید');
    else if (phone == null)
      return const Left('شماره موبایل را وارد کنید');
    else if (category == null)
      return const Left('دسته بندی را انتخاب کنید');
    else if (address == null)
      return const Left('آدرس را وارد کنید');
    else if (lat == null)
      return const Left('آدرس را روی نقشه انتخاب کنید');
    else if (lng == null)
      return const Left('آدرس را روی نقشه انتخاب کنید');
    else if (logo == null)
      return const Left('لوگو را آپلود کنید');
    else if (pocket == null)
      return const Left('بسته را انتخاب کنید');
    else
      return const Right(true);
  }

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
