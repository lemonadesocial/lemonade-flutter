part of 'community_bloc.dart';

@freezed
class CommunityState with _$CommunityState {
  const factory CommunityState({
    @Default(CommunityStatus.initial) CommunityStatus status,
    @Default([]) List<CommunityUser> friendList,
    @Default([]) List<CommunityUser> followerList,
    @Default([]) List<CommunityUser> followeeList,
    @Default([]) List<CommunityUser> usersSpotlightList,
    String? error,
  }) = _CommunityState;

  factory CommunityState.initial() => const CommunityState();
}

enum CommunityStatus {
  initial,
  loading,
  loaded,
  error,
}
