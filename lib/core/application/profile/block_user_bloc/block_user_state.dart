part of 'block_user_bloc.dart';

@freezed
class BlockUserState with _$BlockUserState {
  const factory BlockUserState({
    @Default(BlockUserStatus.initial) BlockUserStatus status,
    @Default('') String blockUserId,
  }) = _BlockUserState;

  factory BlockUserState.initial() => const BlockUserState();
}

enum BlockUserStatus {
  initial,
  loading,
  blockSuccess,
  unblockSuccess,
  error,
}
