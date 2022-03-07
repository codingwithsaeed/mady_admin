import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';

class SellerModel extends BaseModel<List<Seller>> {
  const SellerModel({required int success, List<Seller>? data})
      : super(success: success, data: data );

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
        success: json["success"],
        data: List<Seller>.from(json["data"].map((x) => Seller.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
