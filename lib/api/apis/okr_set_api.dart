import 'dart:io';

import '../clients/api_client.dart';
import '../../exceptions/api_exception.dart';
import '../../model/okr_set.dart';
import '../../util/extensions/http_response_extension.dart';

class OkrSetAPi {
  final ApiClient apiClient;

  OkrSetAPi(this.apiClient);

  Future<Response> _getAllOkrSetsWithHttpInfo() async {
    const path = '/okrSet';

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
    if(response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await apiClient.decodeBodyBytes(response));
    }

    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserialize(await apiClient.decodeBodyBytes(response), 'OkrSet') as List<OkrSet>;
    }

    return <OkrSet>[];
  }
}
