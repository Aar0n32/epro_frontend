import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import '../../exceptions/api_exception.dart';

class ApiClient {
  final String basePath;
  final List<String>? authentication;

  ApiClient({this.basePath = 'http://localhost', this.authentication});

  final _client = Client();
  final _defaultHeaderMap = <String, String>{};

  Map<String, String> get defaultHeaderMap => _defaultHeaderMap;

  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  Future<Response> invokeAPI(
    String path,
    String method,
    List<String> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? contentType,
  ) async {
    if(authentication != null && authentication!.length == 2){
      headerParams[authentication![0]] = authentication![1];
    }

    headerParams.addAll(_defaultHeaderMap);
    if (contentType != null) {
      headerParams['Content-Type'] = contentType;
    }

    final queryString =
        queryParams.isNotEmpty ? '?${queryParams.join('&')}' : '';
    final url = Uri.parse('$basePath$path$queryString');

    try {
      final msgBody = body == null ? '' : json.encode(body);
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      switch (method) {
        case 'POST':
          return await _client.post(url,
              headers: nullableHeaderParams, body: msgBody);
        case 'PUT':
          return await _client.put(url,
              headers: nullableHeaderParams, body: msgBody);
        case 'DELETE':
          return await _client.delete(url,
              headers: nullableHeaderParams, body: msgBody);
        case 'PATCH':
          return await _client.patch(url,
              headers: nullableHeaderParams, body: msgBody);
        case 'HEAD':
          return await _client.head(url, headers: nullableHeaderParams);
        case 'GET':
          return await _client.get(url, headers: nullableHeaderParams);
      }
    } on SocketException catch (error, stackTrace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Socket operation failed: $method $path',
        error,
        stackTrace,
      );
    } on TlsException catch (error, stackTrace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'TLS/SSL operation failed: $method $path',
        error,
        stackTrace,
      );
    } on IOException catch (error, stackTrace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'I/O operation failed: $method $path',
        error,
        stackTrace,
      );
    } on ClientException catch (error, stackTrace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'HTTP connection failed: $method $path',
        error,
        stackTrace,
      );
    } on Exception catch (error, stackTrace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Exception occurred: $method $path',
        error,
        stackTrace,
      );
    }

    throw ApiException(
      HttpStatus.badRequest,
      'Invalid HTTP operation: $method $path',
    );
  }
}
