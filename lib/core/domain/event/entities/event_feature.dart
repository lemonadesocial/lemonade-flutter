import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_feature.g.dart';
part 'event_feature.freezed.dart';

@freezed
class EventFeature with _$EventFeature {
  @JsonSerializable(explicitToJson: true)
  const factory EventFeature({
    String? id,
    String? code,
    String? name,
    bool? featureEnable,
  }) = _EventFeature;

  factory EventFeature.fromJson(Map<String, dynamic> json) =>
      _$EventFeatureFromJson(json);
}
