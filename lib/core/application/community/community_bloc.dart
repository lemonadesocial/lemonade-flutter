import 'package:app/core/domain/community/community_repository.dart';
import 'package:app/core/domain/community/community_user/community_user.dart';
import 'package:app/core/utils/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_bloc.freezed.dart';

part 'community_state.dart';

class CommunityBloc extends Cubit<CommunityState> {
  CommunityBloc(this._repository) : super(CommunityState.initial());

  final CommunityRepository _repository;

  final debouncer = Debouncer(milliseconds: 500);

  Future<void> getListFriend(
    String userId, {
    String? searchInput,
  }) async {
    emit(state.copyWith(status: CommunityStatus.loading));
    final response = await _repository.getListFriend(
      userId,
      searchInput: searchInput,
    );

    response.fold(
      (l) {},
      (friendList) => emit(
        state.copyWith(
          status: CommunityStatus.loaded,
          friendList: friendList,
        ),
      ),
    );
  }

  Future<void> getListFollower(
    String userId, {
    String? searchInput,
  }) async {
    emit(state.copyWith(status: CommunityStatus.loading));
    final response = await _repository.getListFollower(
      userId,
      searchInput: searchInput,
    );

    response.fold(
      (l) {},
      (receiveList) => emit(
        state.copyWith(
          status: CommunityStatus.loaded,
          followerList: receiveList,
        ),
      ),
    );
  }

  Future<void> getListFollowee(
    String userId, {
    String? searchInput,
  }) async {
    emit(state.copyWith(status: CommunityStatus.loading));
    final response = await _repository.getListFollowee(
      userId,
      searchInput: searchInput,
    );

    response.fold(
      (l) {},
      (receiveList) => emit(
        state.copyWith(
          status: CommunityStatus.loaded,
          followeeList: receiveList,
        ),
      ),
    );
  }

  void onSearchInputChange(
    CommunityType type, {
    required String userId,
    String? searchInput,
  }) {
    debouncer.run(() {
      switch (type) {
        case CommunityType.friend:
          getListFriend(userId, searchInput: searchInput);
          break;
        case CommunityType.follower:
          getListFollower(userId, searchInput: searchInput);
          break;
        case CommunityType.followee:
          getListFollowee(userId, searchInput: searchInput);
          break;
      }
    });
  }

  Future<void> getUsersSpotlight() async {
    emit(state.copyWith(status: CommunityStatus.loading));
    final response = await _repository.getUsersSpotlight();

    response.fold(
      (l) {},
      (list) => emit(
        state.copyWith(
          status: CommunityStatus.loaded,
          usersSpotlightList: list,
        ),
      ),
    );
  }
}

enum CommunityType {
  friend,
  follower,
  followee,
}
