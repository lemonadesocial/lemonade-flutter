import 'package:freezed_annotation/freezed_annotation.dart';

part 'badge_input.g.dart';
part 'badge_input.freezed.dart';

@freezed
class GetBadgesInput with _$GetBadgesInput {
  @JsonSerializable(
    includeIfNull: false,
  )
  factory GetBadgesInput({
    int? skip,
    int? limit,
    List<String>? list,
    @JsonKey(name: '_id') List<String>? id,
    String? city,
    String? country,
    double? distance,
  }) = _GetBadgesInput;
  
  factory GetBadgesInput.fromJson(Map<String, dynamic> json) => _$GetBadgesInputFromJson(json);
}

@freezed
class GetBadgeListsInput with _$GetBadgeListsInput {
  @JsonSerializable(
    includeIfNull: false,
  )
  factory GetBadgeListsInput({
    int? skip,
    int? limit,
    String? user,
    String? title,
  }) = _GetBadgeListsInput;
  
  factory GetBadgeListsInput.fromJson(Map<String, dynamic> json) => _$GetBadgeListsInputFromJson(json);  
}

@freezed
class GetBadgeCitiesInput with _$GetBadgeCitiesInput {
  @JsonSerializable(
    includeIfNull: false,
  )
  factory GetBadgeCitiesInput({
    int? skip,
    int? limit,
    String? user,
    String? title,
  }) = _GetBadgeCitiesInput;
  
  factory GetBadgeCitiesInput.fromJson(Map<String, dynamic> json) => _$GetBadgeCitiesInputFromJson(json);  
}
