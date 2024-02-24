import 'package:injectable/injectable.dart';

import 'apis/auth_api.dart';
import 'clients/unauthenticated_api_client.dart';

@module
abstract class ApiRegisterModule {
  @singleton
  AuthApi authApi(UnauthenticatedApiClient apiClient) => AuthApi(apiClient);
}