import 'package:freezed_annotation/freezed_annotation.dart';

part 'quest_group.freezed.dart';
part 'quest_group.g.dart';

@freezed
class QuestGroup with _$QuestGroup {
  @JsonSerializable(explicitToJson: true)
  const factory QuestGroup({
    String? id,
    String? title,
    int? position,
  }) = _QuestGroup;

  factory QuestGroup.fromJson(Map<String, dynamic> json) =>
      _$QuestGroupFromJson(json);
}
