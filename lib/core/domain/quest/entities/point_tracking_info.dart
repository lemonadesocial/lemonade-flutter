import 'package:freezed_annotation/freezed_annotation.dart';

part 'point_tracking_info.g.dart';
part 'point_tracking_info.freezed.dart';

@freezed
class PointTrackingInfo with _$PointTrackingInfo {
  @JsonSerializable(explicitToJson: true)
  const factory PointTrackingInfo({
    String? id,
    String? config,
    double? points,
    DateTime? createdAt,
  }) = _PointTrackingInfo;

  factory PointTrackingInfo.fromJson(Map<String, dynamic> json) =>
      _$PointTrackingInfoFromJson(json);
}
