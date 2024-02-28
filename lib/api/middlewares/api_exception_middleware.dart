import 'dart:io';

import 'package:injectable/injectable.dart';

import 'i_middleware.dart';
import '../request_context.dart';
import '../../constants/enums/e_error_codes.dart';
import '../../exceptions/okr_api_exception.dart';
import '../../exceptions/api_exception.dart';
import '../../services/logging/i_loggable.dart';
import '../../services/logging/i_logging_service.dart';
import '../../util/extensions/http_response_extension.dart';

@singleton
class ApiExceptionMiddleware extends ILoggable implements IMiddleware {
  final ILoggingService _loggingService;

  ApiExceptionMiddleware(this._loggingService) : super(_loggingService);

  @override
  Future<Response> execute({
    required Future<Response> Function(RequestContext) next,
    required RequestContext requestContext,
  }) async {
    try {
      _loggingService.info('stat running Middleware...');
      final response = await next(requestContext);
      if (response.statusCode < HttpStatus.badRequest) {
        return response;
      }
      throw ApiException(response.statusCode, await response.decodeBodyBytes());
    } on ApiException catch (exception, stackTrace) {
      throw _parseException(exception, stackTrace);
    } finally {
      _loggingService.info('end running Middleware');
    }
  }

  Exception _parseException(ApiException exception, StackTrace stackTrace) {
    switch (exception.code) {
      case 400:
        final socketException = exception.innerException;
        if (socketException is SocketException) {
          return OkrApiException(
            innerException: exception,
            stackTrace: stackTrace,
            errorCode: socketException.osError?.message == 'Connection refused'
                ? ErrorCodes.serverNotAvailable
                : ErrorCodes.noInternetConnection,
          );
        }
        if(socketException is ClientException){
          return OkrApiException(
            innerException: exception,
            stackTrace: stackTrace,
            errorCode: ErrorCodes.noInternetConnection,
          );
        }
        return OkrApiException(
          innerException: exception,
          stackTrace: stackTrace,
          errorCode: ErrorCodes.badRequest,
        );
      case 401:
      case 403:
        return UnauthenticatedUserException(
          innerException: exception,
          stackTrace: stackTrace,
        );
      case 500:
        return OkrApiException(
          innerException: exception,
          stackTrace: stackTrace,
          errorCode: ErrorCodes.internalServerError,
        );
      default:
        return OkrApiException(
          innerException: exception,
          stackTrace: stackTrace,
          errorCode: ErrorCodes.unknownError,
        );
    }
  }
}
