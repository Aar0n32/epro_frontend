import 'dart:io';

import 'package:epro_frontend/api/clients/api_client.dart';
import 'package:epro_frontend/exceptions/api_exception.dart';
import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/model/unit_create_dto.dart';
import 'package:epro_frontend/util/extensions/http_response_extension.dart';

class UnitApi {
  final ApiClient apiClient;

  UnitApi(this.apiClient);

  Future<Response> _getAllUnitsWithHttpInfo() async {
    const path = '/api/units';

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

  Future<List<Unit>> getAllUnits() async {
    final response = await _getAllUnitsWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }

    if (response.body.isNotEmpty &&
        response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserialize(
          await apiClient.decodeBodyBytes(response), 'Unit') as List<Unit>;
    }

    return <Unit>[];
  }

  Future<Response> _createUnitWithHttpInfo(UnitCreateDto unit) async {
    const path = '/api/units/create';

    Object? postBody = unit;

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

  Future<void> createUnit(UnitCreateDto unit) async {
    final response = await _createUnitWithHttpInfo(unit);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }
  }

  Future<Response> _moveUnitWithHttpInfo(Map<String, dynamic> json, int id) async {
    final path = '/api/units/$id/changeParent';

    Object? postBody = json;

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

  Future<void> moveUnit(int parentId, int unitId) async {
    final response = await _moveUnitWithHttpInfo({"newParentUnitId": parentId}, unitId);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(
          response.statusCode, await apiClient.decodeBodyBytes(response));
    }
  }
}
