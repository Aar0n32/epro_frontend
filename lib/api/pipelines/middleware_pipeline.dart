import 'dart:collection';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../request_context.dart';
import '../middlewares/i_middleware.dart';
import '../../services/logging/i_logging_service.dart';

@injectable
class MiddlewarePipeline {
  final Queue<IMiddleware> middlewares = Queue<IMiddleware>();

  final ILoggingService? _loggingService;

  MiddlewarePipeline(this._loggingService){
    _loggingService?.init(runtimeType.toString());
  }

  MiddlewarePipeline addFirst(IMiddleware middleware){
    middlewares.addFirst(middleware);
    return this;
  }

  MiddlewarePipeline addLast(IMiddleware middleware){
    middlewares.addLast(middleware);
    return this;
  }

  Future<Response> excecute({
    required RequestContext requestContext,
    required Future<Response> Function(RequestContext context) fetchApi}) async {
    _loggingService?.debug('start executing MiddlewarePipeline...');
    return _recursive(0, requestContext, fetchApi).whenComplete(() => _loggingService?.debug('end executing MiddlewarePipeline'));
  }

  Future<Response> _recursive(int i, RequestContext requestContext, Future<Response> Function(RequestContext) next){
    if(middlewares.isEmpty || i == middlewares.length){
      return next(requestContext);
    }
    return middlewares.elementAt(i).execute(next: (requestContext) => _recursive(i+1, requestContext, next), requestContext: requestContext);
  }
}