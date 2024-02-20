import 'base_exception.dart';
import '../constants/enums/e_error_codes.dart';

class OkrApiException extends BaseException {
  OkrApiException({
    super.message,
    super.innerException,
    required super.errorCode,
    super.stackTrace,
  });
}

class UnauthenticatedUserException extends OkrApiException {
  UnauthenticatedUserException({
    super.message,
    super.innerException,
    super.stackTrace,
  }) : super(errorCode: ErrorCodes.unauthorizedUser);
}