import 'package:app/core/data/collaborator/dtos/user_discovery_swipe_dto/user_discovery_swipe_dto.dart';
import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/graphql/backend/schema.graphql.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_discovery_swipe.freezed.dart';
part 'user_discovery_swipe.g.dart';

@freezed
class UserDiscoverySwipe with _$UserDiscoverySwipe {
  const UserDiscoverySwipe._();

  factory UserDiscoverySwipe({
    String? id,
    Enum$UserDiscoverySwipeDecision? decision1,
    Enum$UserDiscoverySwipeDecision? decision2,
    String? message,
    String? other,
    User? otherExpanded,
    Enum$UserDiscoverySwipeSource? source,
    DateTime? stamp,
    Enum$UserDiscoverySwipeState? state,
    String? user1,
    String? user2,
  }) = _UserDiscoverySwipe;

  factory UserDiscoverySwipe.fromDto(UserDiscoverySwipeDto dto) =>
      UserDiscoverySwipe(
        id: dto.id,
        decision1: dto.decision1,
        decision2: dto.decision2,
        message: dto.message,
        other: dto.other,
        otherExpanded:
            dto.otherExpanded != null ? User.fromDto(dto.otherExpanded!) : null,
        source: dto.source,
        stamp: dto.stamp,
        state: dto.state,
        user1: dto.user1,
        user2: dto.user2,
      );

  factory UserDiscoverySwipe.fromJson(Map<String, dynamic> json) =>
      _$UserDiscoverySwipeFromJson(json);
}
