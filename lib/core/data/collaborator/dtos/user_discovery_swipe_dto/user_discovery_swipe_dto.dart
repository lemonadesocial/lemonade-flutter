import 'package:app/core/data/user/dtos/user_dtos.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_discovery_swipe_dto.freezed.dart';
part 'user_discovery_swipe_dto.g.dart';

@freezed
class UserDiscoverySwipeDto with _$UserDiscoverySwipeDto {
  factory UserDiscoverySwipeDto({
    @JsonKey(name: '_id') String? id,
    Enum$UserDiscoverySwipeDecision? decision1,
    Enum$UserDiscoverySwipeDecision? decision2,
    String? message,
    String? other,
    @JsonKey(name: 'other_expanded') UserDto? otherExpanded,
    Enum$UserDiscoverySwipeSource? source,
    DateTime? stamp,
    Enum$UserDiscoverySwipeState? state,
    String? user1,
    String? user2,
  }) = _UserDiscoverySwipeDto;

  factory UserDiscoverySwipeDto.fromJson(Map<String, dynamic> json) =>
      _$UserDiscoverySwipeDtoFromJson(json);
}
