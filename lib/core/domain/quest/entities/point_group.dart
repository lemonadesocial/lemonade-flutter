import 'package:app/core/domain/quest/entities/group.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_group.g.dart';
part 'point_group.freezed.dart';

@freezed
class PointGroup with _$PointGroup {
  @JsonSerializable(explicitToJson: true)
  const factory PointGroup({
    Group? firstLevelGroup,
    List<Group>? secondLevelGroups,
    int? points,
    int? count,
    int? completed,
  }) = _PointGroup;

  factory PointGroup.fromJson(Map<String, dynamic> json) =>
      _$PointGroupFromJson(json);
}
