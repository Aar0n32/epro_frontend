import 'dart:convert';

import 'package:http/http.dart';
export 'package:http/http.dart';

extension HttpResponseExtension on Response {
  Future<String> decodeBodyBytes() async => isContentTypeJson()
      ? bodyBytes.isEmpty
          ? ''
          : utf8.decode(bodyBytes)
      : body;

  bool isContentTypeJson() {
    final contentType = headers['content-type'];
    return contentType != null && contentType.toLowerCase().contains('json');
  }
}
