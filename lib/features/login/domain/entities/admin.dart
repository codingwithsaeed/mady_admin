import 'package:equatable/equatable.dart';

class Admin extends Equatable {
  final String _id;
  final String _username;

  const Admin(this._id, this._username);

  String get id => _id;
  String get username => _username;

  @override
  List<Object?> get props => [_id, _username];

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        json["aid"],
        json["username"],
      );

  Map<String, dynamic> toJson() => {
        "aid": id,
        "username": username,
      };
}
