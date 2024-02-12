import 'package:http/http.dart';

import '../request_context.dart';

abstract class IMiddleware {
  Future<Response> execute({
    required Future<Response> Function(RequestContext) next,
    required RequestContext requestContext,
  });
}
