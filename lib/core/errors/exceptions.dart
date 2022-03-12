import 'package:equatable/equatable.dart';

const notFoundException = 'Not found';

class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

class SharedException extends Equatable implements Exception {
  final String message;

  const SharedException({required this.message});

  @override
  List<Object?> get props => [message];
}
