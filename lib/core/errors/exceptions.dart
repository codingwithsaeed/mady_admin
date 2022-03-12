const notFoundException = 'Not found';

class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

class SharedException implements Exception {
  final String message;

  const SharedException({required this.message});
}
