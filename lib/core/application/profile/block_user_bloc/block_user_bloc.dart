import 'package:app/core/domain/user/entities/user.dart';
import 'package:app/core/domain/user/user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';

part 'block_user_bloc.freezed.dart';

part 'block_user_state.dart';

class BlockUserBloc extends Cubit<BlockUserState> {
  BlockUserBloc(this.userRepository) : super(BlockUserState.initial());

  final UserRepository userRepository;

  Future<void> blockUser({
    required String userId,
  }) async {
    emit(state.copyWith(status: BlockUserStatus.loading));
  }
}
