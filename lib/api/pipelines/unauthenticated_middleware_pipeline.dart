import 'package:injectable/injectable.dart';

import 'middleware_pipeline.dart';
import '../middlewares/api_exception_middleware.dart';
import '../../services/logging/i_logging_service.dart';

class UnauthenticatedMiddlewarePipeline extends MiddlewarePipeline {
  UnauthenticatedMiddlewarePipeline(super.loggingService);

  @factoryMethod
  static UnauthenticatedMiddlewarePipeline create(
      ILoggingService loggingService,
      ApiExceptionMiddleware apiExceptionMiddleware,
      ){
    UnauthenticatedMiddlewarePipeline middlewarePipeline = UnauthenticatedMiddlewarePipeline(loggingService);
    middlewarePipeline.initialize(
      apiExceptionMiddleware,
    );
    return middlewarePipeline;
  }

  void initialize(
      ApiExceptionMiddleware apiExceptionMiddleware
      ) => addLast(apiExceptionMiddleware);
}