import '../constants/enums/e_error_codes.dart';

class BaseException implements Exception {
  final String? message;
  final ErrorCodes errorCode;
  final Exception? innerException;
  final StackTrace? stackTrace;

  BaseException({this.message, required this.errorCode, this.innerException, this.stackTrace});

  @override
  String toString() {
    return '$runtimeType{message: $message, errorCode: $errorCode, innerException: $innerException}';
  }
}