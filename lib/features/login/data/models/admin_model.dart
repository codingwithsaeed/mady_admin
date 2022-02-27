import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/features/login/domain/entities/admin.dart';

class AdminModel extends BaseModel<Admin> {
  const AdminModel({required int success, Admin? data})
      : super(success: success, data: data);

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
      success: json['success'],
      data: json.containsKey('data') ? Admin.fromJson(json['data']) : null);

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}
