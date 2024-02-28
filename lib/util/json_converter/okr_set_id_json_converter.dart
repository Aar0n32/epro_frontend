import 'package:json_annotation/json_annotation.dart';

class OkrSetIdJsonConverter implements JsonConverter<int, Map<String, dynamic>>{
  const OkrSetIdJsonConverter();

  @override
  int fromJson(Map<String, dynamic> json) => json['id'];

  @override
  Map<String, dynamic> toJson(int id) => {'id': id};
}