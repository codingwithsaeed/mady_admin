import 'package:equatable/equatable.dart';

class BaseModel<Type> extends Equatable {
  final int success;
  final Type? data;

  const BaseModel({required this.success, this.data});

  @override
  List<Object?> get props => [success, data];
}
