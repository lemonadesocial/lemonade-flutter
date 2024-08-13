import 'package:app/core/data/event/dtos/event_feature_dto/event_feature_dto.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_feature.g.dart';
part 'event_feature.freezed.dart';

@freezed
class EventFeature with _$EventFeature {
  @JsonSerializable(explicitToJson: true)
  const factory EventFeature({
    String? id,
    Enum$FeatureCode? code,
    String? name,
    bool? featureEnable,
    List<String>? endpoints,
  }) = _EventFeature;

  factory EventFeature.fromDto(EventFeatureDto dto) => EventFeature(
        id: dto.id,
        code: dto.code,
        name: dto.name,
        featureEnable: dto.featureEnable,
      );

  factory EventFeature.fromJson(Map<String, dynamic> json) =>
      _$EventFeatureFromJson(json);
}
