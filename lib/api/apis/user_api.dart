import 'dart:io';

import 'package:epro_frontend/api/clients/api_client.dart';
import 'package:epro_frontend/exceptions/api_exception.dart';
import 'package:epro_frontend/model/user.dart';
import 'package:epro_frontend/model/user_create_dto.dart';
import 'package:epro_frontend/util/extensions/http_response_extension.dart';

class UserApi {
  final ApiClient apiClient;

  UserApi(this.apiClient);

  Future<Response> _getMeWithHttpInfo() async {
    const path = '/api/users/me';

    Object? postBody;

    final queryParams = <String>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<User?> getMe() async {
    final response = await _getMeWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }

    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserialize(
          await apiClient.decodeBodyBytes(response), 'User') as User;
    }

    return null;
  }

  Future<Response> _getAllUsersWithHttpInfo() async {
    const path = '/api/users';

    Object? postBody;

    final queryParams = <String>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];

    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<List<User>> getAllUsers() async {
    final response = await _getAllUsersWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }

    if (response.body.isNotEmpty &&
    response.statusCode != HttpStatus.noContent) {
    return await apiClient.deserialize(
    await apiClient.decodeBodyBytes(response), 'Users') as List<User>;
    }

    return <User>[];
  }

  Future<Response> _createUserWithHttpInfo(UserCreateDto user) async {
    const path = '/api/users/create';

    Object? postBody = user;

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

  Future<void> createUser(UserCreateDto user) async {
    final response = await _createUserWithHttpInfo(user);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }
  }
}