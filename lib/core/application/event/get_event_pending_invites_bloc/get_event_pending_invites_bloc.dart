import 'package:app/core/domain/event/entities/event_invite.dart';
import 'package:app/core/domain/event/event_repository.dart';
import 'package:app/injection/register_module.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_event_pending_invites_bloc.freezed.dart';

class GetEventPendingInvitesBloc
    extends Bloc<GetEventPendingInvitesEvent, GetEventPendingInvitesState> {
  GetEventPendingInvitesBloc()
      : super(const GetEventPendingInvitesState.initial()) {
    on<_Fetch>(_onGetEventPendingInvites);
  }

  Future<void> _onGetEventPendingInvites(
    _Fetch event,
    Emitter<GetEventPendingInvitesState> emit,
  ) async {
    emit(const GetEventPendingInvitesState.loading());

    final result = await getIt<EventRepository>().getEventPendingInvites();

    result.fold(
      (failure) => emit(const GetEventPendingInvitesState.failure()),
      (response) => emit(
        GetEventPendingInvitesState.fetched(
          pendingInivitesResponse: response,
        ),
      ),
    );
  }
}

@freezed
class GetEventPendingInvitesEvent with _$GetEventPendingInvitesEvent {
  const factory GetEventPendingInvitesEvent.fetch() = _Fetch;
}

@freezed
class GetEventPendingInvitesState with _$GetEventPendingInvitesState {
  const factory GetEventPendingInvitesState.initial() = _Initial;
  const factory GetEventPendingInvitesState.loading() = _Loading;
  const factory GetEventPendingInvitesState.fetched({
    required GetEventPendingInvitesResponse pendingInivitesResponse,
  }) = _Fetched;
  const factory GetEventPendingInvitesState.failure() = _Failure;
}
