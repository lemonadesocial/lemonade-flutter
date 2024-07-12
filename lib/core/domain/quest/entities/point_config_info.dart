import 'package:app/core/domain/quest/entities/point_tracking_info.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_config_info.g.dart';
part 'point_config_info.freezed.dart';

@freezed
class PointConfigInfo with _$PointConfigInfo {
  @JsonSerializable(explicitToJson: true)
  const factory PointConfigInfo({
    String? id,
    Enum$PointType? type,
    String? title,
    double? points,
    bool? firstTimeOnly,
    String? firstLevelGroup,
    String? secondLevelGroup,
    List<PointTrackingInfo>? trackings,
  }) = _PointConfigInfo;

  factory PointConfigInfo.fromJson(Map<String, dynamic> json) =>
      _$PointConfigInfoFromJson(json);
}
