const notFoundException = 'Not found';

class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}
