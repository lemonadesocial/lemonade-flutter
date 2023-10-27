import 'package:app/core/domain/user/user_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_user_bloc.freezed.dart';

class DeleteUserBloc extends Bloc<DeleteUserEvent, DeleteUserState> {
  final userRepository = getIt<UserRepository>();

  DeleteUserBloc() : super(DeleteUserState.idle()) {
    on<DeleteUserEventDelete>(_onDeleteUser);
  }

  Future<void> _onDeleteUser(DeleteUserEventDelete event, Emitter emit) async {
    emit(DeleteUserState.loading());
    final result = await userRepository.deleteUser();
    result.fold((l) => emit(DeleteUserState.failure()), (success) {
      if (success) {
        emit(DeleteUserState.success());
      } else {
        emit(DeleteUserState.failure());
      }
    });
  }
}

@freezed
class DeleteUserEvent with _$DeleteUserEvent {
  factory DeleteUserEvent.delete() = DeleteUserEventDelete;
}

@freezed
class DeleteUserState with _$DeleteUserState {
  factory DeleteUserState.idle() = DeleteUserStateIdle;
  factory DeleteUserState.loading() = DeleteUserStateLoading;
  factory DeleteUserState.success() = DeleteUserStateSuccess;
  factory DeleteUserState.failure() = DeleteUserStateFailure;
}
