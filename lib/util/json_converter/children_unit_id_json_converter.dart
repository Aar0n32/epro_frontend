import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

class ChildrenUnitIdJsonConverter
    implements JsonConverter<List<int>, List<dynamic>?> {
  const ChildrenUnitIdJsonConverter();

  @override
  List<int> fromJson(List<dynamic>? json) {
    if(json == null) return <int>[];
    List<int?> list = json.map((e) => jsonDecode(e)['id'] as int?).toList();
    return list.where((element) => element != null).map((e) => e!).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<int> ids) =>
      ids.map((id) => {'id': id}).toList();
}
