// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddOffer extends Equatable {
  AddOffer(
      {this.sellerPhone,
      this.content,
      this.date,
      this.sTime,
      this.eTime,
      this.price,
      this.percent,
      this.currentPrice,
      this.picture,
      this.count,
      this.isSpecial,
      this.status});

  final String action = 'insert_offer';
  late String? sellerPhone;
  late String? content;
  late String? date;
  late String? sTime;
  late String? eTime;
  late String? price;
  late String? percent;
  late String? currentPrice;
  late String? picture;
  late String? count;
  late String? isSpecial;
  late String? status;

  Either<String, bool> validate() {
    if (sellerPhone == null)
      return const Left('شماره فروشنده را وارد کنید');
    else if (content == null)
      return const Left('محتویات بسته را وارد کنید');
    else if (date == null)
      return const Left('تاریخ را انتخاب کنید');
    else if (sTime == null)
      return const Left('زمان شروع را وارد کنید');
    else if (eTime == null)
      return const Left('زمان پایان را انتخاب کنید');
    else if (price == null)
      return const Left('قیمت را وارد کنید');
    else if (percent == null)
      return const Left('درصد تخفیف را وارد کنید');
    else if (currentPrice == null)
      return const Left('قیمت پس از تخفیف را وارد کنید');
    else if (picture == null)
      return const Left('تصویر را بارگذاری کنید');
    else if (count == null)
      return const Left('تعداد را وارد کنید');
    else if (isSpecial == null)
      return const Left('نوع بسته را انتخاب کنید');
    else if (status == null)
      return const Left('وضعیت بسته را انتخاب کنید');
    else
      return const Right(true);
  }

  Map<String, dynamic> toJson() => {
        "action": action,
        "sellerPhone": sellerPhone,
        "content": content,
        "date": date,
        "sTime": sTime,
        "eTime": eTime,
        "price": price,
        "percent": percent,
        "currentPrice": currentPrice,
        "picture": picture,
        "count": count,
        "isSpecial": isSpecial,
        "status": status,
      };

  @override
  List<Object?> get props => [
        action,
        sellerPhone,
        content,
        date,
        sTime,
        eTime,
        price,
        percent,
        currentPrice,
        picture,
        count,
        isSpecial,
        status,
      ];
}
