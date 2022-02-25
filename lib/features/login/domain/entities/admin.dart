import 'package:equatable/equatable.dart';

class Admin extends Equatable{
  final int _id;
  final String _username;

  const Admin(this._id, this._username);

  int get id => _id;
  String get username => _username;

  @override
  List<Object?> get props => [_id, _username];
}
