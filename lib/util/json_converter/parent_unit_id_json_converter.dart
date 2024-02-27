import 'package:json_annotation/json_annotation.dart';

class ParentUnitIdJsonConverter implements JsonConverter<int?, Map<String,dynamic>>{
  const ParentUnitIdJsonConverter();

  @override
  int? fromJson(Map<String, dynamic> json) => json['id'];

  @override
  Map<String, dynamic> toJson(int? id) => {'id': id};
}