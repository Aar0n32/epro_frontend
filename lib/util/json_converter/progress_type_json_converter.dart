import 'package:json_annotation/json_annotation.dart';

import '../../constants/enums/e_progress_type.dart';

class ProgressTypeJsonConverter
    implements JsonConverter<EProgressType, String> {
  const ProgressTypeJsonConverter();

  @override
  EProgressType fromJson(String json) =>EProgressType.values
        .firstWhere((element) => element.toString() == json.toLowerCase());


  @override
  String toJson(EProgressType type) => type.name.toUpperCase();
}