import 'package:app/core/domain/community/community_repository.dart';
import 'package:app/core/domain/community/community_user/community_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_bloc.freezed.dart';
part 'community_state.dart';

class CommunityBloc extends Cubit<CommunityState> {
  CommunityBloc(this._repository) : super(CommunityState.initial());

  final CommunityRepository _repository;

  Future<void> getListFriend(
    String userId, {
    String? searchInput,
  }) async {
    emit(state.copyWith(status: CommunityStatus.loading));
    print('getListFriend called');
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
    print('getListFollower called');
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
    print('getListFollowee called');
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
}
