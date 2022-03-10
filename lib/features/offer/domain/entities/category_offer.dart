import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';

class CategoryOffer extends BaseModel<List<Offer>> {
  final String name;
  const CategoryOffer(
      {required this.name, required int success, List<Offer>? data})
      : super(success: success, data: data);

  factory CategoryOffer.fromJson(Map<String, dynamic> json) => CategoryOffer(
      name: json['name'],
      success: json["success"],
      data: List<Offer>.from(json["data"].map((x) => Offer.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "success": success,
        "name": name,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
