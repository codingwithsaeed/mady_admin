import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mady_admin/core/error/failures.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Params extends Equatable {
  final Map<String, dynamic> _param;

  const Params(this._param);

  Map<String, dynamic> get param => _param;

  @override
  List<Object?> get props => [_param];
}
