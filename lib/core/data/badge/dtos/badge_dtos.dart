import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_dtos.g.dart';
part 'badge_dtos.freezed.dart';

@freezed
class BadgeDto with _$BadgeDto {
  @JsonSerializable(explicitToJson: true)
  factory BadgeDto({
    @JsonKey(name: '_id') String? id,
    String? city,
    String? country,
    bool? claimable,
    double? distance,
    String? list,
    @JsonKey(name: 'list_expanded') BadgeListDto? listExpanded,
    String? contract,
    String? network,
  }) = _BadgeDto;

  factory BadgeDto.fromJson(Map<String, dynamic> json) =>
      _$BadgeDtoFromJson(json);
}

@freezed
class BadgeListDto with _$BadgeListDto {
  @JsonSerializable(explicitToJson: true)
  factory BadgeListDto({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'image_url') String? imageUrl,
    String? title,
    String? user,
    UserDto? userExpanded,
  }) = _BadgeListDto;

  factory BadgeListDto.fromJson(Map<String, dynamic> json) =>
      _$BadgeListDtoFromJson(json);
}

@freezed
class BadgeCityDto with _$BadgeCityDto {
  factory BadgeCityDto({
    String? city,
    String? country,
  }) = _BadgeCityDto;

  factory BadgeCityDto.fromJson(Map<String, dynamic> json) =>
      _$BadgeCityDtoFromJson(json);
}
