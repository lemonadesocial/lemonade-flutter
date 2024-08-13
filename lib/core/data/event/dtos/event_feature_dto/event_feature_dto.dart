import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_feature_dto.freezed.dart';
part 'event_feature_dto.g.dart';

@freezed
class EventFeatureDto with _$EventFeatureDto {
  factory EventFeatureDto({
    @JsonKey(name: '_id', includeIfNull: false) String? id,
    Enum$FeatureCode? code,
    String? name,
    List<String>? endpoints,
    @JsonKey(name: 'feature_enable', includeIfNull: false) bool? featureEnable,
  }) = _EventFeatureDto;

  factory EventFeatureDto.fromJson(Map<String, dynamic> json) =>
      _$EventFeatureDtoFromJson(json);
}
