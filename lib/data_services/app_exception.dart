class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  dynamic messages;

  FetchDataException([dynamic message]) : super(message) {
    messages = message;
  }
}

class BadRequestException extends AppException {
  dynamic messages;

  BadRequestException([dynamic message]) : super(message) {
    messages = message;
  }
}

class UnauthorisedException extends AppException {
  dynamic messages;

  UnauthorisedException([dynamic message]) : super(message) {
    messages = message;
  }
}

class TokenExpiredException extends AppException {
  dynamic messages;

  TokenExpiredException([dynamic message]) : super(message) {
    messages = message;
  }
}

class InvalidInputException extends AppException {
  dynamic messages;

  InvalidInputException([dynamic message]) : super(message) {
    messages = message;
  }
}


class InternalServerDataException extends AppException {
  dynamic messages;

  InternalServerDataException([dynamic message]) : super(message) {
    messages = message;
  }
}

class NotFoundDataException extends AppException {
  dynamic messages;

  NotFoundDataException([dynamic message]) : super(message) {
    messages = message;
  }
}
