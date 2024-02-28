import 'dart:io';

import 'package:epro_frontend/model/edit_okr_set.dart';
import 'package:epro_frontend/model/update_key_result.dart';

import '../clients/api_client.dart';
import '../../exceptions/api_exception.dart';
import '../../model/okr_set.dart';
import '../../util/extensions/http_response_extension.dart';

class OkrSetAPi {
  final ApiClient apiClient;

  OkrSetAPi(this.apiClient);

  Future<Response> _getAllOkrSetsWithHttpInfo() async {
    const path = '/api/okrSet';

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

  Future<List<OkrSet>> getAllOkrSets() async {
    final response = await _getAllOkrSetsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }

    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserialize(
          await apiClient.decodeBodyBytes(response), 'OkrSets') as List<OkrSet>;
    }

    return <OkrSet>[];
  }

  Future<Response> _getOkrSetWithHttpInfo(int id) async {
    final path = '/api/okrSet/$id';

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

  Future<OkrSet?> getOkrSet(int id) async {
    final response = await _getOkrSetWithHttpInfo(id);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }

    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserialize(
          await apiClient.decodeBodyBytes(response), 'OkrSet') as OkrSet;
    }

    return null;
  }

  Future<Response> _updateKeyResultWithHttpInfo(
      UpdateKeyResult updateKeyResult, int okrSetId) async {
    final path = '/api/okrSet/$okrSetId/updateKeyResult';

    Object? postBody = updateKeyResult;

    final queryParams = <String>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = ['application/json'];

    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<void> updateKeyResult(
      UpdateKeyResult updateKeyResult, int okrSetId) async {
    final response =
        await _updateKeyResultWithHttpInfo(updateKeyResult, okrSetId);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }
  }

  Future<Response> _editOkrSetWithHttpInfo(EditOkrSet okrSet, int id) async {
    final path = '/api/okrSet/$id/edit';

    Object? postBody = okrSet;

    final queryParams = <String>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = ['application/json'];

    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<void> editOkrSet(EditOkrSet okrSet, int id) async {
    final response = await _editOkrSetWithHttpInfo(okrSet, id);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }
  }
}
