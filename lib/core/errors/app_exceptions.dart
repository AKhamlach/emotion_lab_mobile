class AppException implements Exception {
  const AppException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'AppException($code): $message';
}

class AuthException extends AppException {
  const AuthException(super.message, {super.code});
}

class NetworkException extends AppException {
  const NetworkException(
      [super.message = 'A network error occurred. Please try again.']);
}

class StorageException extends AppException {
  const StorageException(
      [super.message = 'Failed to access local storage.']);
}

class ValidationException extends AppException {
  const ValidationException(super.message);
}
