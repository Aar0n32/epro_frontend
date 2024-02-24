import 'package:injectable/injectable.dart';

import 'unauthenticated_api_client.dart';
import '../pipelines/authenticated_middleware_pipeline.dart';

@singleton
class AuthenticatedApiClient extends UnauthenticatedApiClient {
  AuthenticatedApiClient(AuthenticatedMiddlewarePipeline middlewarePipeline) : super(middlewarePipeline);
}