import 'package:injectable/injectable.dart';


import 'unauthenticated_middleware_pipeline.dart';
import '../middlewares/api_exception_middleware.dart';
import '../middlewares/auth_middleware.dart';
import '../../services/logging/i_logging_service.dart';

@injectable
class AuthenticatedMiddlewarePipeline extends UnauthenticatedMiddlewarePipeline {
  AuthenticatedMiddlewarePipeline(super.loggingService);

  @factoryMethod
  static AuthenticatedMiddlewarePipeline create(
      ILoggingService loggingService,
      ApiExceptionMiddleware apiExceptionMiddleware,
      AuthMiddleware authMiddleware,
      ){
    AuthenticatedMiddlewarePipeline middlewarePipeline = AuthenticatedMiddlewarePipeline(loggingService);
    middlewarePipeline.initialize(
      apiExceptionMiddleware,
    );
    middlewarePipeline.addFirst(authMiddleware);
    return middlewarePipeline;
  }
}