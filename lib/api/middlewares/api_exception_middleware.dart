import 'dart:io';

import 'i_middleware.dart';
import '../request_context.dart';
import '../../exceptions/api_exception.dart';
import '../../services/logging/i_loggable.dart';
import '../../services/logging/i_logging_service.dart';
import '../../util/extensions/http_response_extension.dart';

class ApiExceptionMiddleware extends ILoggable implements IMiddleware {
  final ILoggingService _loggingService;

  ApiExceptionMiddleware(this._loggingService) : super(_loggingService);

  @override
  Future<Response> execute({
    required Future<Response> Function(RequestContext) next,
    required RequestContext requestContext,
  }) async {
    try{
      _loggingService.debug('stat running Middleware...');
      final response = await next(requestContext);
      if(response.statusCode < HttpStatus.badRequest){
        return response;
      }
      throw ApiException(response.statusCode, await response.decodeBodyBytes());
    } on ApiException catch (exception, stackTrace){
      throw _parseException(exception, stackTrace);
    } finally {
      _loggingService.debug('end running Middleware');
    }
  }

  Exception _parseException(ApiException exception, StackTrace stackTrace){
    return exception;
  }
}
