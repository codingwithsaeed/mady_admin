const NOT_FOUND_EX = 'Not found';

class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}
