import 'package:epro_frontend/api/apis/unit_api.dart';
import 'package:epro_frontend/api/apis/user_api.dart';
import 'package:injectable/injectable.dart';

import 'apis/auth_api.dart';
import 'apis/okr_set_api.dart';
import 'clients/unauthenticated_api_client.dart';
import 'clients/authenticated_api_client.dart';

@module
abstract class ApiRegisterModule {
  @singleton
  AuthApi authApi(UnauthenticatedApiClient apiClient) => AuthApi(apiClient);

  @singleton
  OkrSetAPi okrSetAPi(AuthenticatedApiClient apiClient) => OkrSetAPi(apiClient);

  @singleton
  UnitApi unitApi(AuthenticatedApiClient apiClient) => UnitApi(apiClient);

  @singleton
  UserApi userApi(AuthenticatedApiClient apiClient) => UserApi(apiClient);
}