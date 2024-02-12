import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import 'api_client.dart';
import '../pipelines/unauthenticated_middleware_pipeline.dart';
import '../request_context.dart';

@singleton
class UnauthenticatedApiClient extends ApiClient {
  static const _defaultPath = 'http://localhost';
  String _basePath = _defaultPath;

  final UnauthenticatedMiddlewarePipeline _middlewarePipeline;

  UnauthenticatedApiClient(this._middlewarePipeline);

  @override
  String get basePath => _basePath;

  set basePath(String basePath) {
    _basePath = basePath;
  }

  @override
  Future<Response> invokeAPI(
    String path,
    String method,
    List<String> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? contentType,
  ) async {
    return await _middlewarePipeline.excecute(
      requestContext: RequestContext(path, method, queryParams, body,
          headerParams, formParams, contentType),
      fetchApi: _fetchRequestContext,
    );
  }

  Future<Response> _fetchRequestContext(RequestContext requestContext) async {
    return await super
        .invokeAPI(
          requestContext.path,
          requestContext.method,
          requestContext.queryParams,
          requestContext.body,
          requestContext.headerParams,
          requestContext.formParams,
          requestContext.contentType,
        )
        .timeout(const Duration(minutes: 1));
  }
}
