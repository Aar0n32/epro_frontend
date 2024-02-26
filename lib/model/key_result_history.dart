import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'key_result_history.g.dart';

@JsonSerializable()
class KeyResultHistory extends Equatable {
  final int id;
  final double progress;
  final String comment;
  final DateTime date;

  const KeyResultHistory(this.id, this.progress, this.comment, this.date);

  factory KeyResultHistory.fromJson(Map<String, dynamic> json) => _$KeyResultHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$KeyResultHistoryToJson(this);

  @override
  List<Object?> get props => [id, progress, comment, date];
}