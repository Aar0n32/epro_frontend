import 'package:epro_frontend/constants/enums/e_progress_type.dart';
import 'package:epro_frontend/util/json_converter/progress_type_json_converter.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_key_result.g.dart';

@JsonSerializable()
class UpdateKeyResult extends Equatable {
  final int id;
  final double newProgress;
  final String comment;
  @ProgressTypeJsonConverter()
  final EProgressType type;

  const UpdateKeyResult(this.id, this.newProgress, this.comment, this.type);

  factory UpdateKeyResult.fromJson(Map<String, dynamic> json) => _$UpdateKeyResultFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateKeyResultToJson(this);

  @override
  List<Object?> get props => [id, newProgress, comment, type];
}