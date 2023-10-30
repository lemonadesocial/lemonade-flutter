import 'package:app/core/domain/notification/input/delete_notifications_input.dart';
import 'package:app/core/domain/notification/notification_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_notifications_bloc.freezed.dart';

class DeleteNotificationsBloc
    extends Bloc<DeleteNotificationsEvent, DeleteNotificationsState> {
  final notificationRepository = getIt<NotificationRepository>();
  DeleteNotificationsBloc() : super(DeleteNotificationsState.idle()) {
    on<DeleteNotificationsEventDelete>(_onDelete);
  }

  Future<void> _onDelete(
    DeleteNotificationsEventDelete event,
    Emitter emit,
  ) async {
    final result =
        await notificationRepository.deleteNotifications(input: event.input);
    result.fold(
      (failure) => emit(
        DeleteNotificationsState.failure(),
      ),
      (success) => emit(
        success
            ? DeleteNotificationsState.success()
            : DeleteNotificationsState.failure(),
      ),
    );
  }
}

@freezed
class DeleteNotificationsEvent with _$DeleteNotificationsEvent {
  factory DeleteNotificationsEvent.delete({
    required DeleteNotificationsInput input,
  }) = DeleteNotificationsEventDelete;
}

@freezed
class DeleteNotificationsState with _$DeleteNotificationsState {
  factory DeleteNotificationsState.idle() = DeleteNotificationsStateIdle;
  factory DeleteNotificationsState.loading() = DeleteNotificationsStateLoading;
  factory DeleteNotificationsState.success() = DeleteNotificationsStateSuccess;
  factory DeleteNotificationsState.failure() = DeleteNotificationsStateFailure;
}
