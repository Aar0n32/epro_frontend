import 'dart:io';

import 'package:http/http.dart';

import '../clients/api_client.dart';
import '../../exceptions/api_exception.dart';
import '../../model/tokens_dto.dart';
import '../../model/login_dto.dart';

class AuthApi {
  final ApiClient apiClient;

  AuthApi(this.apiClient);

  Future<Response> _loginWithHttpInfo(LoginDto loginDto) async {
    const path = '/api/auth/login';

    Object? postBody = loginDto;

    final queryParams = <String>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = ['application/json'];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<TokensDto?> login(LoginDto loginDto) async {
    final response = await _loginWithHttpInfo(loginDto);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }

    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserialize(
          await apiClient.decodeBodyBytes(response), 'TokensDto') as TokensDto;
    }
    return null;
  }

  Future<Response> logoutWithHttpInfo(String token) async {
    const path = '/api/auth/logout';

    Object? postBody;

    final queryParams = <String>[];
    final headerParams = <String, String>{'Authorization': 'Bearer $token'};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isNotEmpty ? null : contentTypes.first,
    );
  }

  Future<void> logout(String token) async {
    final response = await logoutWithHttpInfo(token);
    if(response.statusCode >= HttpStatus.badRequest){
      throw ApiException(response.statusCode, await apiClient.decodeBodyBytes(response));
    }
  }
}
