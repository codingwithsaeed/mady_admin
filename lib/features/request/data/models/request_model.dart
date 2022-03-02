import 'package:mady_admin/core/models/base_model.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';

class RequestModel extends BaseModel<List<Request>> {
  const RequestModel({required int success, List<Request>? data})
      : super(success: success, data: data);

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
      success: json['success'],
      data: json.containsKey('data')
          ? List<Request>.from(json['data'].map((x) => Request.fromJson(x)))
          : null);

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
