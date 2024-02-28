import 'dart:convert';
import 'dart:io';

import 'package:epro_frontend/model/unit.dart';
import 'package:epro_frontend/model/user.dart';
import 'package:http/http.dart';

import '../../exceptions/api_exception.dart';
import '../../model/okr_set.dart';
import '../../model/login_dto.dart';
import '../../model/tokens_dto.dart';

class ApiClient {
  final String basePath;
  final List<String>? authentication;

  ApiClient({this.basePath = 'http://localhost:8080', this.authentication});

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
    if (authentication != null && authentication!.length == 2) {
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

  Future<String> decodeBodyBytes(Response response) async {
    final contentType = response.headers['content-type'];
    return contentType != null &&
            contentType.toLowerCase().startsWith('application/json')
        ? response.bodyBytes.isEmpty
            ? ''
            : utf8.decode(response.bodyBytes)
        : response.body;
  }

  Future<dynamic> deserialize(String value, String targetType,
          {bool growable = false}) async =>
      _deserialize(value, targetType, growable);

  dynamic _deserialize(String value, String targetType, bool growable) {
    return targetType == 'String'
        ? value
        : _fromJson(json.decode(value), targetType, growable);
  }

  dynamic _fromJson(dynamic value, String targetType, bool growable) {
    try {
      switch (targetType) {
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'bool':
          if (value is bool) return value;
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
        case 'DateTime':
          return value is DateTime ? value : DateTime.tryParse('$value');
        case 'LoginDto':
          return LoginDto.fromJson(value);
        case 'TokensDto':
          return TokensDto.fromJson(value);
        case 'OkrSet':
          return (value as List).map((e) => OkrSet.fromJson(e)).toList();
        case 'Unit':
          return (value as List).map((e) => Unit.fromJson(e)).toList();
        case 'Users':
          return (value as List).map((e) => User.fromJson(e)).toList();
        case 'User':
          return User.fromJson(value);
        default:
          dynamic match;
          if (value is List &&
              (match = RegExp(r'^List<(.*)>$')
                      .firstMatch(targetType)
                      ?.group(1)) !=
                  null) {
            return value
                .map<dynamic>((dynamic e) => _fromJson(e, match, growable))
                .toList(growable: growable);
          }
          if (value is Set &&
              (match = RegExp(r'^Set<(.*)>$')
                      .firstMatch(targetType)
                      ?.group(1)) !=
                  null) {
            return value
                .map<dynamic>((dynamic e) => _fromJson(e, match, growable))
                .toSet();
          }
          if (value is Map &&
              (match = RegExp(r'^Map<String,(.*)>$')
                      .firstMatch(targetType)
                      ?.group(1)) !=
                  null) {
            return Map<String, dynamic>.fromIterables(
                value.keys.cast<String>(),
                value.values.map<dynamic>(
                    (dynamic e) => _fromJson(e, match, growable)));
          }
      }
    } on Exception catch (error, stackTrace) {
      throw ApiException.withInner(HttpStatus.internalServerError,
          'Exception during deserialization', error, stackTrace);
    }
    throw ApiException(HttpStatus.internalServerError,
        'Could not find suitable class for deserialization');
  }
}
